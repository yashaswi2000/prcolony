import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/screens/Home/Reslist.dart';
import 'package:prcolony/screens/Home/gross.dart';
import 'package:prcolony/screens/Home/grosslist.dart';
import 'package:prcolony/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/Shared/loading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Resident extends StatefulWidget {
  User user;
  Resident({this.user});

  @override
  _ResidentState createState() => _ResidentState();
}

class _ResidentState extends State<Resident> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

@override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) async {
      DatabaseService data = DatabaseService(uid: widget.user.uid);
      await data.UpdateTokencollection(token);
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Gross>>.value(
            value: DatabaseService(uid: user.uid).reside,
            child: StreamBuilder<UserData>(
              stream:  DatabaseService(uid: user.uid).userData,
               builder: (context,snapshot) {
                 if(snapshot.hasData)
                 {
                  UserData userData = snapshot.data;
                       print(userData.name);
                       return DefaultTabController(
                                      length: 2,
                                      child: Scaffold(
                                        backgroundColor: Colors.grey,
                                                  appBar: AppBar(
                                                     backgroundColor: Colors.black54,
                                                                  title: Text("${userData.name}"),
                                                                  actions: <Widget>[FlatButton.icon(label: Text("Logout",style: TextStyle(color: Colors.white)),icon: Icon(Icons.power_settings_new,color: Colors.white,), onPressed: () async{ await AuthService().signOutGoogle();})],
                                                                  bottom: TabBar(
                                                                                  tabs: [
                                                                                          Tab(icon: Icon(Icons.local_grocery_store),text: "Orders",),
                                                                                          Tab(icon: Icon(Icons.airport_shuttle),text:"On the way"),
                                                                                        ],
                                                                                ),
                                                                ),
                                                  body: TabBarView(
                                                            children: [
                                                                      //Icon(Icons.phone),
                                                                      GrossList(),
                                                                      Logres(),
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
                 return Loading();
                                          }
            ),
      
    );
  }
}