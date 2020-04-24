import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/screens/Home/gross.dart';
import 'package:prcolony/screens/Home/grosslist.dart';
import 'package:prcolony/screens/Home/resident.dart';
import 'package:prcolony/screens/Home/volunteer.dart';
import 'package:prcolony/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/User.dart';
import 'package:prcolony/models/UserData.dart';
import 'package:prcolony/models/gross.dart';

class Home extends StatelessWidget {
  
   
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return  StreamBuilder<UserData>(
                    stream: DatabaseService(uid: user.uid).userData,
                    builder: (context,snapshot) {
                       UserData userData = snapshot.data;
                       print(userData.name);
                       if(userData.cat=='RESIDENT')
                       {
                          return Resident();
                       }
                       else
                       {
                          return Volunteer();
                       }
        }
          );
  }
}