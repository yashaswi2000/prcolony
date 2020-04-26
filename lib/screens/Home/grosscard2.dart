import 'package:flutter/material.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/expandlist.dart';

class GrossCard2 extends StatelessWidget {

  final Gross gross;
  final int index;
  UserData user;
  GrossCard2({this.gross,this.index,this.user});

  @override
  Widget build(BuildContext context) {
  return Card(
    color: Colors.black54,
    child: Column(
      //mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        //  ListTile(
        //    isThreeLine: true,
        //   //leading: Icon(Icons.album),
        //   title: Text('${gross.username}     Ph:${gross.phone}',
        //   style: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white
        //   ),),
        //   subtitle: Text('address:- Road- ${gross.road},Plot- ${gross.plot}.',
        //   textAlign: TextAlign.left,
        //   style: TextStyle(
        //     fontSize: 15,
        //     color: Colors.white
        //   ),
        //   ),
        //   trailing: Text("Price : ${gross.price}Rs",
        //   style: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white,
        //   ),),
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[ Text("${gross.username}",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            ),
            Text("+91 ${gross.phone}",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            )
            ]
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Addr:- Road- ${gross.road}, Plot- ${gross.plot}.',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white
            ),
            ),
            Text("Price : ${gross.price}Rs",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
            ),
            ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("${gross.time.toDate().hour}:${gross.time.toDate().minute} ${gross.time.toDate().day}-${gross.time.toDate().month}-${gross.time.toDate().year}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:FontWeight.bold,
                  color: Colors.blue[500],
                ),
              ),
              FlatButton(
                child: Text('View',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:FontWeight.bold,
                  color: Colors.blue[500],
                  ),
                ),
                onPressed: () { 
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Expand(gross: gross)));
                 },
              ),
            user.cat=="VOLUNTEER" ?  Text('') : FlatButton(
                child: Text('MarkPaid',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight:FontWeight.bold,
                  color: Colors.blue[500],
                  ),
                ),
                onPressed: () async { 
                    DatabaseService data = DatabaseService(uid: user.uid);
                    dynamic result = await data.UpdatePaid(user.name, gross.did);
                 },
              ),
            ],
          ),
        ),
          ],
        // ButtonBar(
        //   alignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Text("${gross.time.toDate().hour}:${gross.time.toDate().minute} ${gross.time.toDate().day}-${gross.time.toDate().month}-${gross.time.toDate().year}",
        //       style: TextStyle(
        //         fontWeight:FontWeight.bold,
        //         color: Colors.blue[500],
        //       ),
        //     ),
        //     FlatButton(
        //       child: Text('View'),
        //       onPressed: () { 
        //         Navigator.push(context, MaterialPageRoute(builder: (context)=>Expand(gross: gross)));
        //        },
        //     ),
        //   user.cat=="VOLUNTEER" ?  Text('') : FlatButton(
        //       child: Text('MarkPaid'),
        //       onPressed: () async { 
        //           DatabaseService data = DatabaseService(uid: user.uid);
        //           dynamic result = await data.UpdatePaid(user.name, gross.did);
        //        },
        //     ),
        //   ],
        // ),
      
    ),
  );
}
}