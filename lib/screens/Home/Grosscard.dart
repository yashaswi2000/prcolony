import 'package:flutter/material.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/expandlist.dart';

class GrossCard extends StatelessWidget {

  final Gross gross;
  GrossCard({this.gross});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Expand(gross: gross)));
            },
            leading: Icon(Icons.shopping_cart),
            title: Text("${gross.username} ,${gross.road},${gross.plot}."),
            subtitle: Text(gross.name,
            style: TextStyle(color: Colors.black),
          ),
      ),
        ),
    )
    );
  }
}