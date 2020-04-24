import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/Grosscard.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/Shared/loading.dart';

class GrossList1 extends StatefulWidget {

  UserData user;
  GrossList1({this.user});

  @override
  _GrossList1State createState() => _GrossList1State();
}

class _GrossList1State extends State<GrossList1> {
  @override
  Widget build(BuildContext context) {

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
                child: GrossCard(gross: gross[index],index: index,user: widget.user),
                );
            },
            );
  }
}