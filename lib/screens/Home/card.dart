import 'package:flutter/material.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/expandlist.dart';

class GrossCard0 extends StatelessWidget {

  final Gross gross;
  final int index;
  UserData user;
  GrossCard0({this.gross,this.index,this.user});

  @override
  Widget build(BuildContext context) {
    List<String> l =  gross.name.split("\n");
    int length = l.length;
    int count = 0;
    for(int i=0;i<length;i++)
    {
      if(l[i].length!=0)
      {
        count++;
      }
    }
    length=count;
  return Card(
    color: Colors.black54,
    child: Column(
      children: <Widget>[
        ListTile(
         //leading: Icon(Icons.album),
         title: Padding(
           padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
           child: Text('Total items ${length}',
           style: TextStyle(
             fontSize: 18,
             fontWeight: FontWeight.bold,
             color: Colors.white,
           ),
           ),
         ),
         subtitle: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Padding(
               padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
               child: gross.delivery ? Text("Order Delivered",
               style: TextStyle(
           fontSize: 15,
           fontWeight: FontWeight.bold,
           color: Colors.white,
         ),
               ) :
               Text("item-1)  ${l[0]}",
               style: TextStyle(
           fontSize: 15,
           fontWeight: FontWeight.bold,
           color: Colors.white,
         ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
               child: Text("${gross.time.toDate().hour}:${gross.time.toDate().minute} ${gross.time.toDate().day}-${gross.time.toDate().month}-${gross.time.toDate().year}",
               style: TextStyle(
           fontSize: 16,
           fontWeight: FontWeight.bold,
           color: Colors.blue[500],
         ),
               ),
             ),
           ],
         ),
         trailing: gross.price=='' ? Text("") :Text("Price : ${gross.price} Rs",
           style: TextStyle(
             fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18, 
           ),
         ),
         onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context)=>Expand(gross: gross)));
         },
            ),
     
      ],
    ),
  );
}
}