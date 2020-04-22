import 'package:flutter/material.dart';


class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
              child: Column(children: <Widget>[
        TextField(
          decoration: InputDecoration(
              border: InputBorder.none, labelText: 'Enter your name:'),
        ),
        TextField(
          decoration: InputDecoration(
              border: InputBorder.none, labelText: 'mobile number:'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          decoration: InputDecoration(
              border: InputBorder.none, labelText: 'street no:'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'plot no:'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          decoration: InputDecoration(
              border: InputBorder.none, labelText: 'full address:'),
        ),
        RaisedButton(child: Text("submit"), onPressed: null),
      ]))),
    );
  }
}
