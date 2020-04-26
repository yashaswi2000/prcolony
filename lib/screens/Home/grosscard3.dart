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
      color: Colors.black54,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Row(
          //   children: <Widget>[

          //   ],
          
           ListTile(
             isThreeLine: true,
             contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 8),
             onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Expand(gross: gross)));
             },
            //leading: Icon(Icons.album),
            title: Text('${gross.username}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Ph:${gross.phone}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
                Text('Addr:- Road- ${gross.road}, Plot- ${gross.plot}.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
               Text("${gross.time.toDate().hour}:${gross.time.toDate().minute} ${gross.time.toDate().day}-${gross.time.toDate().month}-${gross.time.toDate().year}",
                style: TextStyle(
                    color: Colors.blue[500],
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
              ],
            ),
            trailing: Column(
              children: <Widget>[
                
              user.cat=="VOLUNTEER" ? FlatButton(
              child: Text('delivery',
              style: TextStyle(
                color: Colors.blue[500],
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
              ),
              onPressed: () async{ 
                DatabaseService data = DatabaseService();
                await data.UpdateDelivery(user.name, gross.did, user.phone);
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>Expand(gross: gross)));
               },
            ):
            Text('')
            ,
              ],
            ),
          ),

        // user.cat=="VOLUNTEER" ? ButtonBar(
        //   //buttonHeight: 50,
        //   //buttonPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        //   mainAxisSize: MainAxisSize.max,
        //   alignment: MainAxisAlignment.end,
        //   children: <Widget>[
        //     FlatButton(
        //       child: Text('Delivered',
        //       style: TextStyle(
        //         color: Colors.blue[500],
        //         fontWeight: FontWeight.bold,
        //         fontSize: 18
        //       ),
        //       ),
        //       onPressed: () async{ 
        //         DatabaseService data = DatabaseService();
        //         await data.UpdateDelivery(user.name, gross.did, user.phone);
        //         //Navigator.push(context, MaterialPageRoute(builder: (context)=>Expand(gross: gross)));
        //        },
        //     ),
        //   ],
        // ):Text(''),
        ],
      ),
    ),
  );
}
}