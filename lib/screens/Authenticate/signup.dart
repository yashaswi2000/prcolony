import 'package:flutter/material.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:prcolony/screens/Authenticate/phoneauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prcolony/services/auth.dart';
import 'package:prcolony/models/User.dart';
void main()
{
  runApp(SignUp());
}
class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

 /* String phoneNo, verificationId, smsCode;
  String name1;
  String initial_name;
  bool codeSent = false;
  bool isUser = false;
  bool visible = false;
  User userData ; */
  String dropdownValue = 'RESIDENT';
 
/* TextEditingController _phoneNumberController = TextEditingController();
  void getDropDownItem(){
 
  
  }*/
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
     home : Scaffold(
        appBar: AppBar(
          title:  Text("Signup page",style: TextStyle(fontWeight:FontWeight.bold, ),textAlign:TextAlign.center,),
          actions: <Widget>[
            FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text("Login"))
          ],
        ),
        resizeToAvoidBottomPadding: false,
       body : Container(
        
         
         margin : EdgeInsets.fromLTRB(10, 20, 10, 20),
         padding : EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
        child: SingleChildScrollView(
                  child: Column(
               children: <Widget>[
        SizedBox(
                height :120,
           child :
            Image.asset('assets/images/user.png'),
         ),
    
      TextFormField(
        
        
     //   controller: _phoneNumberController,
  decoration: InputDecoration(
    icon :Icon(Icons.person,
    color : Colors.blue,),
     border:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    
                                    width: 5.0),
                              ) ,
   
    labelText: 'Enter your name:'
  ),
),
SizedBox(height:20),
TextFormField(
  decoration: InputDecoration(
    icon : Icon(Icons.phone,
    color : Colors.green,),
     border:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 5.0),
                              ) ,
   
    labelText: 'Mobile Number'
  ),
   keyboardType: TextInputType.number,
   onChanged: (val) {
     setState(() {
       //this.phoneNo=val;
     });
   },
                
),
SizedBox(height:20),
TextFormField(
  decoration: InputDecoration(
    icon :Icon(Icons.streetview,
    color : Colors.black,),
     border:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 5.0),
                              ) ,
  labelText: 'Street No'
  ),
   keyboardType: TextInputType.number,
                
),
SizedBox(height:20),
TextFormField(
  decoration: InputDecoration(
    icon : Icon(Icons.home,
                  color : Colors.red,
                  ),
     border:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 5.0),
                              ) , 
  labelText: 'Plot No'
  ),
   keyboardType: TextInputType.number,
                
),
              SizedBox(
        height :20
              ),
               SizedBox(
                  child :
               Text("please select an option",style: TextStyle(color :Colors.black,fontSize: 20),),
             ),
         
            DropdownButton<String>(
    value: dropdownValue,
    icon: Icon(Icons.arrow_drop_down),
    iconSize: 24,
    elevation: 16,
    style: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
    underline: Container(
      height: 3,
      color :Colors.grey[200],

    ),
    onChanged: (String newValue) {
      setState(() {
        dropdownValue = newValue;
      });
    },
    items: <String>['RESIDENT', 'VOLUNTEER' ]
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
      .toList(),
  ),
          SizedBox(height:10), 
RaisedButton(
                color :Colors.blue,
               padding : EdgeInsets.fromLTRB(30, 15, 30, 15),
              
                child : Text("submit",style:TextStyle(color :Colors.white,fontSize: 18)                     
                           ),onPressed:() async {
                               // verifyPhone(this.phoneNo);
                               // final result = await Navigator.push(context,MaterialPageRoute(builder: (context) => Phoneverificationpage(verificationId:this.verificationId,phonenumber: this.phoneNo,)));
                } ,
                elevation: 5,
               shape :new RoundedRectangleBorder(
                borderRadius :new BorderRadius.circular(30),
                ) , 
                ),
               ]
          ),
        ),
                    ),
         )
           
       
    ,);
  }

 Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
    //  this.verificationId = verId;
      setState(() {
      //  this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      setState(() {
      //  this.codeSent =  true;
      });
    //  this.verificationId = verId;
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