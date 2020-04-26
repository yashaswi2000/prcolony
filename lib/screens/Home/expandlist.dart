import 'package:flutter/material.dart';
import 'package:prcolony/Shared/loading.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/screens/Home/gross.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/UserData.dart';

class Expand extends StatefulWidget {

  Gross gross;
  Expand({this.gross});

  @override
  _ExpandState createState() => _ExpandState();
}

class _ExpandState extends State<Expand> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {

        if(snapshot.hasData)
        {
          UserData localuser = snapshot.data;
        return Scaffold(
           backgroundColor: Colors.grey,
            appBar: AppBar(
              backgroundColor: Colors.black54,
              title: Text(widget.gross.username),
            ),
             resizeToAvoidBottomPadding: false,
            body: SingleChildScrollView(
                         
                          child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                        color: Colors.black54,
                              child: Column(
                    mainAxisSize: MainAxisSize.max,
                  
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 1),
                        child: Row(
                          children: <Widget>[
                            Text("${widget.gross.time.toDate().hour}:${widget.gross.time.toDate().minute} ${widget.gross.time.toDate().day}-${widget.gross.time.toDate().month}-${widget.gross.time.toDate().year}",
                            style: TextStyle(
                                    fontWeight:FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Card(
                                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 1, 8, 2),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                  child: SelectableText(
                                                    widget.gross.name,
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      height: 1.2,
                                                    ),
                                                    cursorColor: Colors.red,
                                                      showCursor: true,
                                                      toolbarOptions: ToolbarOptions(
                                                      copy: true,
                                                      selectAll: true,
                                                      cut: false,
                                                      paste: false
                                                      ),
                                                    ),
                                                ),
                            ],
                          ),
                        ),
                      ),
                      
                    widget.gross.done ? Center(
                      child: widget.gross.paid ? 

                      widget.gross.delivery ? 
                      Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                          children: <Widget>[
                            Text("Order has been Delivered for total price : ${widget.gross.price} Rs.",
                            style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            ),
                            Text("by ${widget.gross.devname}",
                            style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            ),
                            Text("contact ${widget.gross.devphone}.",
                            style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            ),
                          ],
                        ),
                                  )
                      
                      :
                      Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                          children: <Widget>[
                            Text("Order has been accepted for total price : ${widget.gross.price} Rs.",
                            style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            ),
                            Text("by ${widget.gross.sentuser}",
                            style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            ),
                            Text("contact ${widget.gross.sentphone}.",
                            style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            ),
                          ],
                        ),
                                  )
                      
                       : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                          children: <Widget>[
                            Text("Order has been quoted price : ${widget.gross.price}.",
                              style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            ),
                            Text("by ${widget.gross.sentuser}",
                            style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            ),
                            Text("contact ${widget.gross.sentphone}.",
                            style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            ),
                          ],
                        ),
                                  ),
                      
                    ) : Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("waiting for order to be processed.",
                            style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ),
                            ),
                          )
                          ,
                    widget.gross.uid==localuser.uid ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: RaisedButton.icon(
                              color: Colors.green,
                                  onPressed: () async {
                                       // DatabaseService data = DatabaseService();
                                       // await data.Deletegross(widget.gross.did);
                                      await  Navigator.push(context, MaterialPageRoute(builder: (context)=>Grossdata(user: user,intialdata: widget.gross.name,gross: widget.gross,)));
                                       Navigator.pop(context);
                                  },
                                   icon: Icon(Icons.file_upload,color: Colors.white,), 
                                   label: Text("Update",
                                    style: TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 17,
                                color: Colors.white
                                
                              ),
                                   ),
                                   ),
                         ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton.icon(
                            color: Colors.red,
                                  onPressed: () async {
                                        DatabaseService data = DatabaseService();
                                        await data.Deletegross(widget.gross.did);
                                        Navigator.pop(context);
                                  },
                                   icon: Icon(Icons.delete,color: Colors.white,), 
                                   label: Text("Delete",
                                   style: TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 17,
                                color: Colors.white,
                              ),
                                   ),
                                   ),
                        ),
                      ],
                    ) : Text(''),
                        ],
                      ),
                    )
                    ],
                  ),
                ),
              ),
            ),
              
        );
        }
        else{
          return Loading();
        }
      }
    );
  }
}