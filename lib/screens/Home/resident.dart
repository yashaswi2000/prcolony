import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/screens/Home/gross.dart';
import 'package:prcolony/screens/Home/grosslist.dart';
import 'package:prcolony/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';

class Resident extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Gross>>.value(
            value: DatabaseService(uid: user.uid).reside,
            child: StreamBuilder<UserData>(
              stream:  DatabaseService(uid: user.uid).userData,
               builder: (context,snapshot) {
                  UserData userData = snapshot.data;
                       print(userData.name);
                       return DefaultTabController(
                                      length: 2,
                                      child: Scaffold(
                                                  appBar: AppBar(
                                                                  title: Text("Welcome ${userData.name}"),
                                                                  actions: <Widget>[IconButton(icon: Icon(Icons.highlight_off), onPressed: () async{ await AuthService().signOut();})],
                                                                  bottom: TabBar(
                                                                                  tabs: [
                                                                                          Tab(icon: Icon(Icons.directions_car)),
                                                                                          Tab(icon: Icon(Icons.directions_transit)),
                                                                                        ],
                                                                                ),
                                                                ),
                                                  body: TabBarView(
                                                            children: [
                                                                      GrossList(),
                                                                      Icon(Icons.shopping_cart),
                                                                      ],
                                                                  ),
                                                  floatingActionButton: FloatingActionButton(onPressed: (){
                                                    Navigator.push(context,MaterialPageRoute(builder: (context) => Grossdata(user:user)));

                                                  },
                                                  child: Icon(Icons.add),
                                                  ),                
                                                    ),
                                                );
                                          }
            ),
      
    );
  }
}