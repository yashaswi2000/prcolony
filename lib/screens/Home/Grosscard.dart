import 'package:flutter/material.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/alert.dart';
import 'package:prcolony/screens/Home/expandlist.dart';

class GrossCard extends StatelessWidget {

  final Gross gross;
  final int index;
  UserData user;
  GrossCard({this.gross,this.index,this.user});

  @override
  Widget build(BuildContext context) {
  return Card(
    color: Colors.black54,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        //  ListTile(
        //    //contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        //   //leading: Icon(Icons.album),
        //   title: Text('${gross.username}     Ph:${gross.phone}',
        //   style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 20,
        //   ),
        //   ),
        //   subtitle: Text('addr:- Road- ${gross.road}, Plot- ${gross.plot}.',
        //   style: TextStyle(
        //     fontSize: 18,
        //   ),
        //   ),
        //   trailing: gross.time.toDate().minute<10 ? Text("${gross.time.toDate().hour}:0${gross.time.toDate().minute}"  ,
        //     style: TextStyle(
        //       fontWeight:FontWeight.bold,
        //     ),
        //   ):Text("${gross.time.toDate().hour}:${gross.time.toDate().minute}"  ,
        //     style: TextStyle(
        //       fontWeight:FontWeight.bold,
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('${gross.username}',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white
            ),
              ),
              Text('Ph:${gross.phone}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white
            ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               Text('addr:- Road- ${gross.road}, Plot- ${gross.plot}.',
               style: TextStyle(
              fontSize: 15,
              color: Colors.white
            ),
               ),
            gross.time.toDate().minute<10 ? Text("${gross.time.toDate().hour}:0${gross.time.toDate().minute}"  ,
              style: TextStyle(
              fontSize: 15,
              color: Colors.white
            ),
            ):Text("${gross.time.toDate().hour}:${gross.time.toDate().minute}"  ,
             style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white
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
              Text("${gross.time.toDate().day}-${gross.time.toDate().month}-${gross.time.toDate().year}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight:FontWeight.bold,
                  color: Colors.blue[500],
                ),
              textAlign: TextAlign.left,
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
              user.cat=="VOLUNTEER" ? Text("")  : FlatButton(
                child: Text('UpdatePrice',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:FontWeight.bold,
                  color: Colors.blue[500],
                ),
                ),
                onPressed: () async {
                    //showAlertDialog(context);
                    print("yee");
                    dynamic res = await Navigator.push(context, MaterialPageRoute(builder: (context)=>Alerter()));
                    print(res);
                    if(res!='' && res!=null)
                    {
                    print("hey there fellas");
                    print("hi there $res");
                    DatabaseService data = DatabaseService(uid: user.uid);
                    dynamic result = await data.UpdateDone(user.name, gross.did,user.uid,res,user.phone);
                    }
                 },
              ),
            ],
          ),
        ),
        // ButtonBar(
        //   //buttonHeight: 50,
        //   //buttonPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        //   mainAxisSize: MainAxisSize.max,
        //   alignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Text("${gross.time.toDate().day}-${gross.time.toDate().month}-${gross.time.toDate().year}",
        //     style: TextStyle(
        //       fontWeight:FontWeight.bold,
        //     ),
        //     textAlign: TextAlign.left,
        //     ),
        //     FlatButton(
        //       child: Text('View'),
        //       onPressed: () { 
        //         Navigator.push(context, MaterialPageRoute(builder: (context)=>Expand(gross: gross)));
        //        },
        //     ),
        //   user.cat=="VOLUNTEER" ? Text("")  : FlatButton(
        //       child: Text('UpdatePrice'),
        //       onPressed: () async {
        //           //showAlertDialog(context);
        //           print("yee");
        //           dynamic res = await Navigator.push(context, MaterialPageRoute(builder: (context)=>Alerter()));
        //           print(res);
        //           if(res!='' && res!=null)
        //           {
        //           print("hey there fellas");
        //           print("hi there $res");
        //           DatabaseService data = DatabaseService(uid: user.uid);
        //           dynamic result = await data.UpdateDone(user.name, gross.did,user.uid,res,user.phone);
        //           }
        //        },
        //     ),
        //   ],
        // ),
      ],
    ),
  );
}
}


showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
     },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}