import 'package:flutter/material.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/expandlist.dart';

class GrossCard3 extends StatelessWidget {

  final Gross gross;
  final int index;
  UserData user;
  GrossCard3({this.gross,this.index,this.user});

  @override
  Widget build(BuildContext context) {
  return Center(
    child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
           ListTile(
            leading: Icon(Icons.album),
            title: Text('${gross.username}     Ph:${gross.phone}'),
            subtitle: Text('address road-${gross.road},plot-${gross.plot}.'),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text('View'),
                onPressed: () { 
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Expand(gross: gross)));
                 },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}