import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/screens/Home/grosscard2.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/Grosscard.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/Shared/loading.dart';

class GrossList2 extends StatefulWidget {

  UserData user;
  GrossList2({this.user});

  @override
  _GrossList2State createState() => _GrossList2State();
}

class _GrossList2State extends State<GrossList2> {
  @override
  Widget build(BuildContext context) {

        return StreamProvider<List<Gross>>.value(
                  value: DatabaseService().completed,
                  child: StreamBuilder<UserData>(
            stream: DatabaseService(uid:widget.user.uid).userData,
            builder: (context, snapshot) {
              final gross = Provider.of<List<Gross>>(context);
              print(gross.length);

              return ListView.builder(
                  itemCount: gross.length,
                  itemBuilder: (context,index){
                    return Dismissible(
                      key: Key(gross[index].username),
                      background: Container(color: Colors.grey),
                      onDismissed: (direction) {
                          //deleteFromList(s);
                },
                      child: GrossCard2(gross: gross[index],index: index,user: widget.user),
                      );
                  },
                  );
            }
          ),
        );
  }
}