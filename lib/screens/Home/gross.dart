import 'package:flutter/material.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/User.dart';

class Grossdata extends StatefulWidget {

  final User user;
  Grossdata({this.user});
  @override
  _GrossdataState createState() => _GrossdataState();
}

class _GrossdataState extends State<Grossdata> {
  //final user = Provider.of<User>(context);
  String listdata='';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
                  child: Column(
                  children : <Widget>[ TextField(
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
            RaisedButton.icon(
              onPressed: () async {
                  if(this.listdata!='')
                  {
                      print(widget.user.uid);
                      DatabaseService data  =  DatabaseService(uid: widget.user.uid);
                      UserData use1 = await data.getuserdocument();
                      dynamic res = await data.UpdateGrosscollection(this.listdata,use1.name,use1.street,use1.plot);
                      if(res)
                      {
                        print("sucess");
                        print(this.listdata);
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
    );
  }
}