import 'package:flutter/material.dart';
import 'package:prcolony/screens/Authenticate/login.dart';
import 'package:prcolony/screens/Authenticate/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool signed = true;
  void toggleView() {
    setState(() {
      signed = !signed;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(signed)
    {
      return SignUp(toggleView: toggleView);
    }
    else
    {
      return Login(toggleView: toggleView);
    }
  }
}