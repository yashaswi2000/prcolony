//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/screens/Home/grosslist.dart';

class DatabaseService {
  final String uid;
  final String stre;
  final String needuser;
  DatabaseService({this.uid,this.needuser,this.stre});

  final CollectionReference UsersCollection = Firestore.instance.collection('Users');
  final CollectionReference Grosslistcollection = Firestore.instance.collection('Gross');
  final CollectionReference Tokenlistcollection = Firestore.instance.collection('Tokens');

  Future UpdateTokencollection(String token) async {
    try{
      await UsersCollection.document(uid).updateData({
        'token':token,
      });
      return true;
    }
    catch(e)
    {
        print(e.toString());
      return false;
    }
  }




  Future UpdateGrosscollection(String name,String username,String street,String plot,Timestamp time,String phone,) async {
    try{
      await Grosslistcollection.document().setData({
        'uid' :uid,
        'name':name,
        'username':username,
        'street':street,
        'plot':plot,
        'done':false,
        'time':time,
        'phone':phone,
        'paid':false,
        'delivery':false,
      });
      return true;
    }
    catch(e)
    {
        print(e.toString());
      return false;
    }
  }

  Future editGrosscollection(String name,String username,String street,String plot,Timestamp time,String phone,String ident) async {
    try{
      await Grosslistcollection.document(ident).updateData({
        'uid' :uid,
        'name':name,
        'username':username,
        'street':street,
        'plot':plot,
        'done':false,
        'time':time,
        'phone':phone,
        'paid':false,
      });
      return true;
    }
    catch(e)
    {
        print(e.toString());
      return false;
    }
  }



  Future Deletegross(String ident) async {
    try{
      await Grosslistcollection.document(ident).delete();
      return true;
    }
    catch(e)
    {
        print(e.toString());
      return false;
    }

  }

  Future UpdateDone(String name,String ident,String sentuid,String price,String phone2) async {
    try{
      await Grosslistcollection.document(ident).updateData({
        'done':true,
        'sentuser':name,
        'sentuid':sentuid,
        'price':price,
        'sentphone':phone2,
      });
      return true;
    }
    catch(e)
    {
        print(e.toString());
      return false;
    }
  }

   Future UpdatePaid(String name,String ident) async {
    try{
      await Grosslistcollection.document(ident).updateData({
        'paid':true,
        'paidmark':name,
        'delivery':false,
      });
      return true;
    }
    catch(e)
    {
        print(e.toString());
      return false;
    }
  }

  Future UpdateDelivery(String name,String ident,String phone) async {
    try{
      await Grosslistcollection.document(ident).updateData({
        'delivery':true,
        'devname':name,
        'devphone':phone
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

  User _userlist(DocumentSnapshot snapshot) {
    return User(
      uid: uid
    );
  }

  Stream<User> get data {
    return UsersCollection.document(uid).snapshots().map(_userlist);
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
        phone: doc.data['phone'] ?? '',
        price: doc.data['price'] ?? '',
        done: doc.data['done'],
        sentphone: doc.data['sentphone'] ?? '',
        sentuser: doc.data['sentuser'] ?? '',
        uid: doc.data['uid'] ?? '',
        paid: doc.data['paid'],
        delivery: doc.data['delivery'] ?? false,
        devname: doc.data['devname'] ?? '',
        devphone: doc.data['devphone'] ?? '',
      );
    }).toList();
  }

   Stream<List<Gross>> get require {
    return Grosslistcollection.where("street",isEqualTo: stre).where("done",isEqualTo: false).orderBy("time").snapshots().map(_grosslist);
  }

  Stream<List<Gross>> get require1 {
    return Grosslistcollection.where("done",isEqualTo: false).orderBy("time").snapshots().map(_grosslist);
  }

   Stream<List<Gross>> get reside {
     print(this.uid);
     return Grosslistcollection.where("uid",isEqualTo: uid).where("paid",isEqualTo: false).orderBy("time",descending: true).snapshots().map(_grosslist);
   }

   Stream<List<Gross>> get residelogs {
     print(this.uid);
     return Grosslistcollection.where("uid",isEqualTo: uid).where("done",isEqualTo: true).where("paid",isEqualTo: true).orderBy("time").snapshots().map(_grosslist);
   }

   Stream<List<Gross>> get completed {
     print(this.uid);
     return Grosslistcollection.orderBy("time").where("sentuser",isEqualTo: needuser).where("done",isEqualTo: true).where("paid",isEqualTo: false).snapshots().map(_grosslist);
   }

   Stream<List<Gross>> get logs {
     print(this.uid);
     return Grosslistcollection.where("done",isEqualTo: true).where("paid",isEqualTo: true).orderBy("time").snapshots().map(_grosslist);
   }

   Stream<List<Gross>> get logsstreet {
     print(this.uid);
     return Grosslistcollection.where("street",isEqualTo: stre).where("done",isEqualTo: true).where("paid",isEqualTo: true).where("delivery",isEqualTo: false).orderBy("time").snapshots().map(_grosslist);
   }

   Stream<List<Gross>> get volunteracess {
     print(this.uid);
     print(stre);
     return Grosslistcollection.orderBy("time").where("street",isEqualTo: stre).where("done",isEqualTo: true).where("paid",isEqualTo: false).snapshots().map(_grosslist);
   }
   

  

  
}
