//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/grosslist.dart';

class DatabaseService {
  final String uid;
  final String stre='4';
  DatabaseService({this.uid});

  final CollectionReference UsersCollection = Firestore.instance.collection('Users');
  final CollectionReference Grosslistcollection = Firestore.instance.collection('Gross');


  Future UpdateGrosscollection(String name,String username,String street,String plot,Timestamp time) async {
    try{
      await Grosslistcollection.document().setData({
        'uid' :uid,
        'name':name,
        'username':username,
        'street':street,
        'plot':plot,
        'done':null,
        'time':time,
      });
      return true;
    }
    catch(e)
    {
        print(e.toString());
      return false;
    }
  }


  Future UpdateUsersCollection(String name, String phonenumber) async {

    try{
       await UsersCollection.document(uid)
        .setData({'name': name, 'phonenumber': phonenumber});
      UsersCollection.document(uid).collection('personaldetails');
      return true;
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
   
  }

  Future<bool> UpdateUserDetails(String name ,String phonenumber,String street,String plot,String cat) async
  {
    try{
      await UsersCollection.document(uid).setData({
        'uid':uid,
        'name':name,
        'phonenumber':phonenumber,
        'street':street,
        'plot':plot,
        'cat':cat , 

      });
      return true;
    }catch(e)
    {
      print(e.toString());
      return false;
    }
  }

 

  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data["name"],
      phone: snapshot.data["phonenumber"],
      street: snapshot.data["street"],
      plot: snapshot.data["plot"],
      cat: snapshot.data["cat"],
    );
  }


 


  //collection stream
  Stream<UserData> get userData {
    return UsersCollection.document(uid).snapshots().map(_userDataFromSnapShot);
  }

  

  

 

  Future<UserData> getuserdocument() async{
    DocumentSnapshot snapshot1 = await UsersCollection.document(uid).get();
   
    return UserData(
      uid: uid,
      name: snapshot1.data["name"],
      phone: snapshot1.data["phonenumber"],
      street: snapshot1.data["street"],
      plot: snapshot1.data["plot"],
      cat: snapshot1.data["cat"],

      

    );
  }

  List<Gross> _grosslist(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Gross(
        did: doc.documentID,
        name: doc.data['name'] ?? '',
        username: doc.data['username'] ?? '',
        road: doc.data['street'] ?? '',
        plot: doc.data['plot'] ?? '',
        time: doc.data['time'] ,
      );
    }).toList();
  }

   Stream<List<Gross>> get require {
    return Grosslistcollection.snapshots().map(_grosslist);
  }

   Stream<List<Gross>> get reside {
     print(this.uid);
     return Grosslistcollection.where("uid",isEqualTo: uid).where("done",isEqualTo: null ).snapshots().map(_grosslist);
   }

  

  
}
