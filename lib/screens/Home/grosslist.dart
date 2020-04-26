import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/screens/Home/card.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/Grosscard.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/Shared/loading.dart';

class GrossList extends StatefulWidget {
  @override
  _GrossListState createState() => _GrossListState();
}

class _GrossListState extends State<GrossList> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    //print(gross.length);
    
    return  StreamBuilder<List<Gross>>(
      stream: DatabaseService(uid: user.uid).reside,
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
         List<Gross> gross = snapshot.data;
        return ListView.builder(
            itemCount: gross.length,
            itemBuilder: (context,index){
              return GrossCard0(gross: gross[index],index: index,);
            },
            );
        }
        return Loading();
      }
    );
  }
}