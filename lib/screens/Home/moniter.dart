 // Sets the context, which in this case is `window`
@JS()
library main3;
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prcolony/Shared/loading.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/screens/Home/gross.dart';
import 'package:prcolony/screens/Home/grosslist.dart';
import 'package:prcolony/screens/Home/grosslist1.dart';
import 'package:prcolony/screens/Home/grosslist2.dart';
import 'package:prcolony/screens/Home/grosslist2new.dart';
import 'package:prcolony/screens/Home/grosslist3.dart';
import 'package:prcolony/screens/Home/grosslist3new.dart';
import 'package:prcolony/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:js' as js;
import 'dart:js_util' as ju;
//import 'package:prcolony/screens/Home/mess.js';



import 'package:js/js.dart';
// @JS('log') // Setting the proxy to the `console.log` method
// external void log(dynamic str);
@JS()
class Promise<T> {
  external Promise(void executor(void resolve(T result), Function reject));
  external Promise then(void onFulfilled(T result), [Function onRejected]);
}


@JS()
external Promise message();



class Moniter extends StatefulWidget {
  User user;
  Moniter({this.user});

  @override
  _MoniterState createState() => _MoniterState();
}

class _MoniterState extends State<Moniter> {

//FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();


//String value;

@override
  void initState() {
    super.initState();

    ju.promiseToFuture(message()).then((token) async {
      DatabaseService data = DatabaseService(uid: widget.user.uid);
      await data.UpdateTokencollection(token);
        print(token);
    });
// //     //message();
// //     //message(); 
// //     //print(value);
// //     //print(value.length);
// //     //js.context.callMethod('message');
// //     //log(result);
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
//     messaging.usePublicVapidKey("BA2k5_y7dIKDCHF0Ch3VHZpz4oOyB5xtQKzJIUH7vz8XUR3ChQ8NEXl3jh0f1UchpCGOAsNsdvMuwHCVIkZ7SJg");
//     messaging.requestPermission().then(
//       () {
//         //console.log('have per head');
//         return messaging.getToken();
//       }
//     ).then((token) {
//       print(token);
//       //console.log(token);
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
                        //print(value);
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
                                    color:Colors.white
                                  ),
                                  ),
                                  icon: Icon(Icons.power_settings_new,color: Colors.white,),
                                    onPressed: () async {
                                      //log('Hello worlddd!');
                                      
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
                            body: TabBarView(
                              children: [
                                GrossList1(user: userData),
                                GrossList2new(user: userData),
                                GrossList3new(user: userData),
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