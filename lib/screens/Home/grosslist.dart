import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/Grosscard.dart';

class GrossList extends StatefulWidget {
  @override
  _GrossListState createState() => _GrossListState();
}

class _GrossListState extends State<GrossList> {
  @override
  Widget build(BuildContext context) {

    final gross = Provider.of<List<Gross>>(context);
    
    return ListView.builder(
      itemCount: gross.length,
      itemBuilder: (context,index){
        return Dismissible(
          key: Key(gross[index].username),
          background: Container(color: Colors.grey),
          onDismissed: (direction) {
              //deleteFromList(s);
    },
          child: Scaffold(
            appBar: AppBar(
              title: Text(gross[index].username),
            ),
          ),
          //GrossCard(gross: gross[index])
          );
      },
      );
  }
}