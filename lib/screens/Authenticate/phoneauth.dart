import 'package:flutter/material.dart';
import 'package:prcolony/Shared/loading.dart';
import 'package:prcolony/database/database.dart';
import 'package:prcolony/screens/Home/home.dart';
import 'package:prcolony/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prcolony/models/User.dart';


import 'package:pin_code_text_field/pin_code_text_field.dart';

class Phoneverificationpage extends StatefulWidget {
   String verificationId;
   String phonenumber;
   bool sent;
   String name;
   String plot,road,cat;
   Phoneverificationpage({Key key, this.sent, this.verificationId, this.phonenumber, this.name, this.plot, this.road, this.cat}) : super(key: key);

  
  @override
  _PhoneverificationpageScreenState createState() =>
      _PhoneverificationpageScreenState();
}

class _PhoneverificationpageScreenState extends State<Phoneverificationpage> {

  bool loading = false;
  String code = "";
  String errormessage = "";
    final AuthService _auth = AuthService();
  bool error = false;
 
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'SMS Verification',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child:Row(
                        children: <Widget>[
                          Expanded(child: RichText(text: TextSpan(children: [
                            TextSpan(
                              text:"Please enter the ",
                              style:TextStyle(color:Colors.white)
                            ),
                            TextSpan(
                              text:"One Time Password ",
                              style:TextStyle(color:Colors.white)
                            ),
                            TextSpan(
                              text:"Sent to ${widget.phonenumber}",
                              style:TextStyle(color:Colors.white)
                            ),
                          ]),))
                        ],
                      )
                    ),
                  ),
                ),
                SizedBox(height: 50),
                PinCodeTextField(
                  pinTextStyle: TextStyle(color: Colors.white),
                  hasTextBorderColor: Colors.green,
                  highlight: true,
                  pinBoxColor: Colors.grey[800],
                  maxLength: 6,
                  pinBoxWidth:40,
                  pinBoxHeight: 40,
                  pinBoxDecoration:
                      ProvidedPinBoxDecoration.roundedPinBoxDecoration,
                  wrapAlignment: WrapAlignment.center,
                  pinTextAnimatedSwitcherTransition:
                      ProvidedPinBoxTextAnimation.scalingTransition,
                  pinTextAnimatedSwitcherDuration: Duration(milliseconds: 100),
                  highlightAnimationBeginColor: Colors.black,
                  highlightAnimationEndColor: Colors.white12,
                  keyboardType: TextInputType.number,
                  hasError: error,
                  autofocus: true,
                  onTextChanged: (temp){
                    print("wow $code");
                    setState(() {
                      error=false;
                      code=temp;

                    });
                  },
                  onDone: (temp){
                    print("Done $temp");
                   
                  },
                ),
                Visibility(
                child: Text(
                  "Wrong PIN!",
                  style: TextStyle(color: Colors.red),
                ),
                visible:error,
              ),
                SizedBox(height: 30),
                FlatButton(
                    
                    onPressed:()async{
                      if(code.isNotEmpty && code.length==6){
                            //AuthService().signInWithOTP(code, widget.verificationId,widget.phonenumber,'ass');
                          setState(() {
                            loading=true;
                          });
                           AuthCredential authCreds = PhoneAuthProvider.getCredential(
                                            verificationId: widget.verificationId,
                                            smsCode: code);
                                            print(widget.verificationId.toString());
                                            //print(authCreds);
                                  AuthResult result =  await FirebaseAuth.instance.signInWithCredential(authCreds);
                                  print(result);
                                  if(result.user!=null)
                                  {
                                    print("ass");
                                    setState(() {
                                        error=false;
                                    });
                                    String uid1 = result.user.uid;
                                  DatabaseService data = DatabaseService(uid: uid1);
                                  bool res = await data.UpdateUserDetails(widget.name, widget.phonenumber, widget.road, widget.plot, widget.cat);
                                  
                                    //Navigator.pop(context,result.user);
                                  }
                                  else
                                  {
                                      print("boo");
                                    setState(() {
                                        error=true;
                                    });
                                      //Navigator.pop(context,null);
                                  }
                                  setState(() {
                                    loading=false;
                                  });
                                  Navigator.pop(context);
                      }
                    
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0,right: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Center(child: Text('Done',style: TextStyle(color: Colors.white,fontSize: 20),),),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }







}
