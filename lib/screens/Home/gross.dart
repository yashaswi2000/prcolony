import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/User.dart';

class Grossdata extends StatefulWidget {

  final User user;
  String intialdata = '';
  Gross gross=null;
  Grossdata({this.user,this.intialdata,this.gross});
  @override
  _GrossdataState createState() => _GrossdataState();
}

class _GrossdataState extends State<Grossdata> {
  //final user = Provider.of<User>(context);
  String listdata='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
          appBar: AppBar(
            backgroundColor: Colors.black54,
            title: Text("enter your list"),
          ),
          body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
                    child: Column(
                    children : <Widget>[ Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                ),
                                                autofocus: true,
                                                initialValue: widget.intialdata,
                                                minLines: 1,
                                                 maxLines: 100,
                                                  maxLengthEnforced: true,
                                                  decoration: InputDecoration(
                                            border:OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 5.0),
                                          ) ,

                                              labelText: 'Enter Your Needs List:'
                                            ),
                                            onChanged: (val){
                                              this.listdata=val;
                                            },
              ),
                    ),
              RaisedButton.icon(
                onPressed: () async {
                    if(this.listdata!='' && widget.gross==null)
                    {
                        print(widget.user.uid);
                        Timestamp time = Timestamp.now();
                        print(time);
                        DatabaseService data  =  DatabaseService(uid: widget.user.uid);
                        UserData use1 = await data.getuserdocument();
                        dynamic res = await data.UpdateGrosscollection(this.listdata,use1.name,use1.street,use1.plot,time,use1.phone);
                        if(res)
                        {
                          print("sucess");
                          print(this.listdata);
                          Navigator.pop(context);
                        }
                        else
                        {
                          print("failed");
                        }
                    }
                    else if(this.listdata!='' && widget.gross!=null)
                    {
                        print(widget.user.uid);
                        Timestamp time = Timestamp.now();
                        print(time);
                        DatabaseService data  =  DatabaseService(uid: widget.user.uid);
                        UserData use1 = await data.getuserdocument();
                        dynamic res = await data.editGrosscollection(this.listdata,use1.name,use1.street,use1.plot,time,use1.phone,widget.gross.did);
                        if(res)
                        {
                          print("sucess");
                          print(this.listdata);
                          Navigator.pop(context);
                        }
                        else
                        {
                          print("failed");
                        }
                    }
                },
                icon: Icon(Icons.add_shopping_cart), 
                label: Text("Submit")
                ),
             ],
            ),
          ),
        ),
      ),
    );
  }
}