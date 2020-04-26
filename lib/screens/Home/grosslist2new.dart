import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/screens/Home/grosscard2.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/gross.dart';
import 'package:prcolony/screens/Home/Grosscard.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/Shared/loading.dart';

class GrossList2new extends StatefulWidget {

  UserData user;
  GrossList2new({this.user});

  @override
  _GrossList2newState createState() => _GrossList2newState();
}

class _GrossList2newState extends State<GrossList2new> {
  @override
  Widget build(BuildContext context) {

        return StreamProvider<List<Gross>>.value(
                  value: DatabaseService(stre:widget.user.street).volunteracess,
                  child: StreamBuilder<UserData>(
            stream: DatabaseService(uid:widget.user.uid).userData,
            builder: (context, snapshot) {
              //final gross = Provider.of<List<Gross>>(context);

              return StreamBuilder<List<Gross>>(
                stream: DatabaseService(stre:widget.user.street).volunteracess,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    List<Gross> gross = snapshot.data;
                    print(gross.length);
                    return ListView.builder(
                      itemCount: gross.length,
                      itemBuilder: (context, index) {
                        return GrossCard2(gross: gross[index],
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