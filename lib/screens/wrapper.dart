import 'package:flutter/material.dart';
import 'package:prcolony/Shared/loading.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/screens/Authenticate/authenticate.dart';
import 'package:prcolony/screens/Authenticate/signup.dart';
import 'package:prcolony/screens/Home/home.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/User.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
        if(user!=null)
        {
            return Home();
        }
        else if(user==null)
        {
            return Authenticate();
        }

         return Loading();
    
  }
}