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

  String phoneNo; 
 static String verificationId, smsCode;
  String plot,road;
  String name1;
  String initial_name;
  bool codeSent = false;
  bool isUser = false;
  bool visible = false;
  User userData ; 
  String dropdownValue = 'RESIDENT';
 String holder = '' ;
  List <String> name = [
    'RESIDENT',
    'VOLUNTEER'
    ] ;
 TextEditingController _phoneNumberController = TextEditingController();
  void getDropDownItem(){
 
    setState(() {
      holder = dropdownValue ;
    });
  }
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
     home : Scaffold(
        appBar: AppBar(
          title: const Text("Signup page",textAlign: TextAlign.center,),
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
                

      SizedBox(height:20),
    
      TextFormField(
        controller: _phoneNumberController,
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
  onChanged: (val){
    setState(() {
      this.name1=val;
    });
  },
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
       this.phoneNo=val;
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
   onChanged: (val){
     setState(() {
       this.road=val;
     });
   }, 
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
   onChanged: (val){
     setState(() {
       this.plot=val;
     });
   },             
),
              SizedBox(
        height :20
              ),
               SizedBox(
               child :
               Text("please select an option",style: TextStyle(color :Colors.black,fontSize: 20),),
             ),
           DropdownButton<String>( 
            value:name[0],
          
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 18),
            underline: Container(
              height: 2,
              padding :EdgeInsets.fromLTRB(40, 20, 10, 20),
              color :Colors.grey[300],
              
            ),
            onChanged: (String data) {
              setState(() {
                dropdownValue = data;
              });
            },
            items: name.map<DropdownMenuItem<String>>((String value1) {
              return DropdownMenuItem<String>(
                value: value1,
                child: Text(value1),
              );
            }).toList(),
          ),  
          SizedBox(height:19), 
RaisedButton(
                color :Colors.blue,
                padding :EdgeInsets.fromLTRB(40, 20, 40, 20),
              
                child : Text("submit",style:TextStyle(color :Colors.white,fontSize: 23),
                                             
                              ),onPressed:() async {
                               await verifyPhone(this.phoneNo);
                                print(_SignUpState.verificationId.toString());
                               
                                
                }   
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

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) async {
      _SignUpState.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
       final result = await Navigator.push(context,MaterialPageRoute(builder: (context) => Phoneverificationpage(
         sent:this.codeSent,
         verificationId:_SignUpState.verificationId.toString(),
         phonenumber: this.phoneNo,
         name: this.name1,
         plot: this.plot,
         road: this.road,
         cat: this.dropdownValue
         )));
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      setState(() {
        this.codeSent =  true;
      });
      _SignUpState.verificationId = verId;
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