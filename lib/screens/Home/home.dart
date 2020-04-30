import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prcolony/Shared/loading.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/screens/Authenticate/signup.dart';
import 'package:prcolony/screens/Home/gross.dart';
import 'package:prcolony/screens/Home/grosslist.dart';
import 'package:prcolony/screens/Home/moniter.dart';
import 'package:prcolony/screens/Home/resident.dart';
import 'package:prcolony/screens/Home/volunteer.dart';
import 'package:prcolony/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

   bool signed = true;
    void toggleView() {
    setState(() {
      signed = !signed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
     print(user);
    //  return Scaffold(
    //           appBar: AppBar(
    //             title: Text("welcome"),
    //           ),
    //           body: Text(user.uid.toString()),
    //         );
    return  StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          UserData dat = snapshot.data;
          // return Scaffold(
          //   appBar: AppBar(
          //     title: Text(dat.name),
          //   ),
          // );
          if(dat.cat=='RESIDENT')
          {
              return Resident(user:user);
          }
          else if(dat.cat=='VOLUNTEER')
          {
            return Moniter(user:user);
          }
          else
          {
            return Volunteer(user:user);
          }
          
        }
        else if(snapshot.hasError)
        {
          return SignUp(toggleView: toggleView,user: user);
        }
        return Loading();
      }
    );
}
}