import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/screens/Home/grosscard3.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/Grosscard.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/Shared/loading.dart';

class GrossList3new extends StatefulWidget {

  UserData user;
  GrossList3new({this.user});

  @override
  _GrossList3newState createState() => _GrossList3newState();
}

class _GrossList3newState extends State<GrossList3new> {
  @override
  Widget build(BuildContext context) {
    
        return StreamProvider<List<Gross>>.value(
                  value: DatabaseService(stre: widget.user.street).logsstreet,
                  child: StreamBuilder<UserData>(
            stream: DatabaseService(uid:widget.user.uid).userData,
            builder: (context, snapshot) {
              //final gross = Provider.of<List<Gross>>(context);


              return StreamBuilder<List<Gross>>(
                stream: DatabaseService(stre: widget.user.street).logsstreet,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    List<Gross> gross = snapshot.data;
                    print(gross.length);
                    return ListView.builder(
                      itemCount: gross.length,
                      itemBuilder: (context, index) {
                        return GrossCard3(gross: gross[index],
                            index: index,
                            user: widget.user);
                      },
                    );
                  }
                  else
                    {
                      return Loading();
                    }
                }
              );
            }
          ),
        );
  }
}