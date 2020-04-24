import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/screens/Home/gross.dart';
import 'package:prcolony/screens/Home/grosslist.dart';
import 'package:prcolony/screens/Home/grosslist1.dart';
import 'package:prcolony/screens/Home/grosslist2.dart';
import 'package:prcolony/screens/Home/grosslist3.dart';
import 'package:prcolony/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';

class Volunteer extends StatelessWidget {

   

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

     return StreamProvider<List<Gross>>.value(
            value: DatabaseService().require,
            child: StreamBuilder<UserData>(
              stream:  DatabaseService(uid: user.uid).userData,
               builder: (context,snapshot) {
                  UserData userData = snapshot.data;
                       print(userData.name);
                       return  DefaultTabController(
                                  length: 3,
                                                child: Scaffold(
                                appBar: AppBar(
                                                  title: Text("Welcome ${userData.name}"),
                                                  actions: <Widget>[IconButton(icon: Icon(Icons.person), onPressed: () async{ await AuthService().signOutGoogle();})],
                                                  bottom: TabBar(
                                                                  tabs: [
                                                                  Tab(icon: Icon(Icons.directions_car)),
                                                                  Tab(icon: Icon(Icons.directions_transit)),
                                                                  Tab(icon: Icon(Icons.directions)),
                                                                        ],
                                                                ),
                                              ),
                                body: TabBarView(
                                            children: [
                                              GrossList1(user: userData),
                                              GrossList2(user: userData),
                                              GrossList3(user: userData),
                                                      ],
                                                ), 
                         ),
                       );
                                          }
            ),
      
    );
  }
}