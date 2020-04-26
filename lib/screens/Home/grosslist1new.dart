import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/Grosscard.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/Shared/loading.dart';

class GrossList1new extends StatefulWidget {

  UserData user;
  GrossList1new({this.user});

  @override
  _GrossList1newState createState() => _GrossList1newState();
}

class _GrossList1newState extends State<GrossList1new> {
  @override
  Widget build(BuildContext context) {

    //final gross = Provider.of<List<Gross>>(context);


        return StreamBuilder<List<Gross>>(
          stream: DatabaseService().require1,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              List<Gross> gross = snapshot.data;
              print(gross.length);
              return ListView.builder(
                    itemCount: gross.length,
                    itemBuilder: (context, index) {
                      return GrossCard(
                          gross: gross[index], index: index, user: widget.user);
                    },
                  );
            }
            else{
              return Loading();
            }
          }
        );
  }
}