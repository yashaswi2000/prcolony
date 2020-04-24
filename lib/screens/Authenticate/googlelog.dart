import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prcolony/services/auth.dart';
import 'package:prcolony/screens/Authenticate/phoneauth.dart';
import 'package:prcolony/Shared/loading.dart';


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


  @override

  Widget build(BuildContext context) {
    return loading ? Loading() : MaterialApp(
     home : Scaffold(
        appBar: AppBar(
          title: const Text('login page', style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

          actions: <Widget>[
            FlatButton.icon(
              onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text("Register"))
          ],
        ),
       
       body :   Container(
         padding : EdgeInsets.fromLTRB(20, 30, 20, 30),
         child : Column(
           
           children: <Widget>[
             SizedBox(height:10),
              SizedBox(
                height :150,
           child :
            Image.asset('assets/images/user.png'),
         ),
SizedBox(
  height:20
),
RaisedButton(
    color :Colors.blue,
            child : Text("login",style: TextStyle(color: Colors.white,fontSize: 18),),
            onPressed:() async {

              setState(() {
                                  loading = true;
                                });
                               await AuthService().signInWithGoogle();
            },
               
            ),
           ]
        )
       )
    ),);
  }

   Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) async{
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
        this.loading=false;
      });

       final result = await Navigator.push(context,MaterialPageRoute(builder: (context) => Phoneverificationpage(
         sent:this.codeSent,
         verificationId:this.verificationId.toString(),
         phonenumber: this.phone,
         road: this.street,
         )));
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      setState(() {
       this.codeSent =  true;
      });
      this.verificationId = verId;
    };

    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }catch(e)
    {
      print(e.toString());

    }
  }
}