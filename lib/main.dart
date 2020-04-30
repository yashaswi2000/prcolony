import 'package:flutter/material.dart';
import 'package:prcolony/screens/wrapper.dart';
import 'package:prcolony/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:prcolony/models/User.dart';
//import "package:universal_html/html.dart";

import 'dart:html' as html;
import 'dart:js' as js;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  void func(){
  js.context.callMethod('alert', ['Hello, world!']);
  // This widget is the root of your application.
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
          value: AuthService().user,
          child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
  
  
}
