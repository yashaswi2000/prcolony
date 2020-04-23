import 'package:flutter/material.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/expandlist.dart';

class GrossCard extends StatelessWidget {

  final Gross gross;
  final int index;
  GrossCard({this.gross,this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Expand(gross: gross)));
            },
            title: Text("${index+1}) ${gross.username}",
              style: TextStyle(fontWeight:FontWeight.bold,
              fontSize: 22,
              ),
            ),
            subtitle: Text("Road-${gross.road},plot-${gross.plot}",
            style: TextStyle(fontWeight:FontWeight.bold,
            fontSize: 18,
            ),
            ),
          ),
      ),
        ),
    );
  }
}