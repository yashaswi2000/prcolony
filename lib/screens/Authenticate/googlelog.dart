import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prcolony/services/auth.dart';
import 'package:prcolony/screens/Authenticate/phoneauth.dart';
import 'package:prcolony/Shared/loading.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';


class Loging extends StatefulWidget {

  final Function toggleView;
  Loging({this.toggleView});

  @override
  _LogingState createState() => _LogingState();
}

class _LogingState extends State<Loging> {

  bool loading = false;
  String phone,verificationId;
  String street='';
  bool codeSent = false;
  //Widget login = const Text(
 //   "Sign in with Google",
  //  style: TextStyle(
   //   color: Colors.white,
   //   fontFamily: "OpenSans-Regular",
   //   fontSize: 23,
   // ),
 // );


  @override

  Widget build(BuildContext context) {
    return loading ? Loading() : MaterialApp(
     home : Scaffold(
      // backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text('login page', style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        ),
       //resizeToAvoidBottomInset: false,
       body :   Center(
         child: Container(
          
           padding : EdgeInsets.fromLTRB(20, 30, 20, 30),
           child : Column(
            // mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
            
               SizedBox(height:30),
                Container(
                  height :150,
                  margin :EdgeInsets.fromLTRB(30, 10, 30, 10),
             child :
             Image.asset('assets/images/user.png',colorBlendMode: BlendMode.screen,),
           ),
SizedBox(
  height:50
),

  Container(
    margin :EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: GoogleSignInButton(
                  darkMode: true,
                  onPressed:() async {
                    setState(() {
                              loading = true;
  
                                });
                   await AuthService().signInWithGoogle();
  
                  },
     ),
   ),
  ]
),
          ),
       )
       ),
    );
  }

   
}