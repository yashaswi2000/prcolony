import 'package:flutter/material.dart';
class Login extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
     home : Scaffold(
       body : Container(
         child : Column(
           children: <Widget>[
      
      TextField(
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: ' name:'
  ),
),
TextField(
  decoration: InputDecoration(
    border: InputBorder.none,
    labelText: 'mobile number:'
  ),
   keyboardType: TextInputType.number,
            
),


RaisedButton(
            child : Text("submit"),onPressed:null   
            ),
           ]
        )
           
       )
    ),);
  }
}