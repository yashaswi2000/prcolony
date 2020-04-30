@JS()
library main1;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prcolony/Shared/loading.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/screens/Home/gross.dart';
import 'package:prcolony/screens/Home/grosslist.dart';
import 'package:prcolony/screens/Home/grosslist1.dart';
import 'package:prcolony/screens/Home/grosslist1new.dart';
import 'package:prcolony/screens/Home/grosslist2.dart';
import 'package:prcolony/screens/Home/grosslist3.dart';
import 'package:prcolony/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:js_util' as ju;


import 'package:js/js.dart';

@JS()
class Promise<T> {
  external Promise(void executor(void resolve(T result), Function reject));
  external Promise then(void onFulfilled(T result), [Function onRejected]);
}


@JS()
external Promise message();



class Volunteer extends StatefulWidget {
  User user;
  Volunteer({this.user});

  @override
  _VolunteerState createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
// FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

@override
  void initState() {
    super.initState();

    ju.promiseToFuture(message()).then((token) async {
      DatabaseService data = DatabaseService(uid: widget.user.uid);
      await data.UpdateTokencollection(token);
        print(token);
    });
//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) {
//         print('on message $message');
//       },
//       onResume: (Map<String, dynamic> message) {
//         print('on resume $message');
//       },
//       onLaunch: (Map<String, dynamic> message) {
//         print('on launch $message');
//       },
//     );
//     _firebaseMessaging.requestNotificationPermissions(
//         const IosNotificationSettings(sound: true, badge: true, alert: true));
//     _firebaseMessaging.getToken().then((token) async {
//       DatabaseService data = DatabaseService(uid: widget.user.uid);
//       await data.UpdateTokencollection(token);      
//       print(token);
//     });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

     return StreamProvider<List<Gross>>.value(
            value: DatabaseService().require,
            child: StreamBuilder<UserData>(
              stream:  DatabaseService(uid: user.uid).userData,
               builder: (context,snapshot) {
                  UserData userData = snapshot.data;
                      if(snapshot.hasData) {
                        print(userData.name);
                        return DefaultTabController(
                          length: 3,
                          child: Scaffold(
                            backgroundColor: Colors.grey,
                            appBar: AppBar(
                              backgroundColor: Colors.black54,
                              title: Text("${userData.name}"),
                              actions: <Widget>[
                                FlatButton.icon(
                                  label: Text("Logout",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  ),
                                  icon: Icon(Icons.power_settings_new,color: Colors.white,),
                                    onPressed: () async {
                                      await AuthService().signOutGoogle();
                                    })
                              ],
                              bottom: TabBar(
                                tabs: [
                                  Tab(icon: Icon(Icons.people),text: "Orders",),
                                  Tab(icon: Icon(Icons.monetization_on),text:"Priced"),
                                  Tab(icon: Icon(Icons.shopping_cart),text: "Done",),
                                ],
                              ),
                            ),
                            body:
                                TabBarView(
                                  children: [
                                    GrossList1new(user: userData),
                                    GrossList2(user: userData),
                                    GrossList3(user: userData),
                                  ],
                                ),
                            floatingActionButton: FloatingActionButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        Grossdata(user: user)));
                              },
                              child: Icon(Icons.add),
                            ),
                            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                          ),
                        );
                      }
                      else
                        {
                          return Loading();
                        }
                                          }
            ),
      
    );
  }
}