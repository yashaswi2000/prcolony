import 'package:flutter/material.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:prcolony/Shared/loading.dart';
import 'package:prcolony/screens/Authenticate/phoneauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prcolony/services/auth.dart';
import 'package:prcolony/models/User.dart';
import 'package:validators/validators.dart' as validator;
import 'dart:ui';
import 'package:keyboard_avoider/keyboard_avoider.dart';

void main() {
  runApp(SignUp());
}

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final focus = FocusNode();
  final hocus =FocusNode();
  final mocus =FocusNode();
  bool loading = false;
  String phoneNo;
  String verificationId, smsCode;
  String plot, road;
  String name1;
  String initial_name;
  bool codeSent = false;
  bool isUser = false;
  bool visible = false;
  User userData;
  String dropdownValue = 'RESIDENT';
  //final focus=FocusNode();
  String validator(String value) {
    if (value.isEmpty) {
      return "enter your name";
    }
    return null;
  }
  //MediaQueryData queryData;

 /* double _overlap = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver.call(this);
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }*/

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _phoneNumberController = TextEditingController();
  void getDropDownItem() {}
   
final ScrollController _scrollController = ScrollController();
  @override
  
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : MaterialApp(
            home: Scaffold(
              // backgroundColor: Colors.grey[200],
               //var screenWidth = MediaQuery.of(context).size.width*0.2;
//var screenHeight = MediaQuery.of(context).size.height;
              appBar: AppBar(
                title: Text(
                  "Signup page",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  FlatButton.icon(
                      onPressed: () {
                        widget.toggleView();
                      },
                      icon: Icon(Icons.person),
                      label: Text("Login"))
                ],
              ),

              resizeToAvoidBottomPadding: false,
              body: OrientationBuilder(
                builder : (context,orientation){
                  if(orientation==Orientation.portrait){
                    return KeyboardAvoider(
                      autoScroll: true,
                  
                
                                  child: SingleChildScrollView(
                  controller: _scrollController,
                    child:Container(
                            margin: EdgeInsets.fromLTRB (5, 0, 18, 10),
                           padding: EdgeInsets.fromLTRB(20, 2.5, 20, 2.5),
                                          child: Form(
                        key: _formKey,

                      
                          child: Column(
                         
                        
                            children: <Widget>[
                            Container(
                              margin :EdgeInsets.fromLTRB(20, 20, 20, 0),

                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.18,
                             // height: 120,
                              child: Image.asset('assets/images/user.png'),
                            ),
                          //  SizedBox(
                           //   height :70,
                                                       TextFormField(
                                
                              //  focusNode: _focusNode,
                                  textInputAction: TextInputAction.next,
                                   autofocus: true,
                                    onFieldSubmitted: (v){
                                     FocusScope.of(context).requestFocus(focus);
                                  },
                                controller: _phoneNumberController,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    ),
                                  //  errorStyle: TextStyle(
                                 //     fontSize :10,
                                //    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide:
                                          BorderSide(color: Colors.red, width: 5.0),
                                    ),
                                    labelText: 'Enter your name:'),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Name is Required";
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    this.name1 = val;
                                  });
                                },
                              ),
                         //   ),
                            SizedBox(height: 20),
                            TextFormField(
                              maxLength: 10,
                              
                              maxLengthEnforced: true,
                                focusNode: focus,
                                 textInputAction: TextInputAction.next,
                                   autofocus: true,
                                onFieldSubmitted: (v){
                  FocusScope.of(context).requestFocus(hocus);
              },
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.green,
                                  ),
                                  counterText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 5.0),
                                  ),
                                  labelText: 'Mobile Number'),
                              keyboardType: TextInputType.number,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Mobile Number is required";
                                }
                                else if(value.length>0&&value.length<10)
                                { 
                                 
                                  return "Enter a Valid 10 digit Mobile Number";
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  this.phoneNo = val;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                               focusNode: hocus,
                                textInputAction: TextInputAction.next,
                                   autofocus: true,
                                    onFieldSubmitted: (v){
                                     FocusScope.of(context).requestFocus(mocus);
                                  },
                              maxLength: 1,
                              maxLengthEnforced: true,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.streetview,
                                    color: Colors.black,
                                  ),
                                  counterText: "",
                                  
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 5.0),
                                  ),
                                  labelText: 'Street No'),
                              keyboardType: TextInputType.number,
                              validator: (String value) {
                                if(value.isNotEmpty)
                                {
                                int nit=int.parse(value);
                                  if(nit>5&&nit==0)
                                {
                                  return "Enter a Valid Street No";
                                }
                                }
                               
                                if (value.isEmpty) {
                                  return "Street No is required";
                                }
                               
                              },
                              onChanged: (val) {
                                setState(() {
                                  this.road = val;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              focusNode: mocus,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.home,
                                    color: Colors.red,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 5.0),
                                  ),
                                  labelText: 'Plot No'),
                              keyboardType: TextInputType.number,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Plot No is required";
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  this.plot = val;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              child: Text(
                                "please select an option",
                                style: TextStyle(color: Colors.black, fontSize: 20),
                              ),
                            ),
                                 Container(
                                   color :Colors.grey[200],
                                   margin : EdgeInsets.fromLTRB(0, 10, 0, 10),
                                   padding :EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                          child: DropdownButton<String>(
                                //    focusNode: focus,
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
                                  color: Colors.grey[200],
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>['RESIDENT', 'VOLUNTEER']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                                 margin :EdgeInsets.only(bottom :20),
                                                      child: RaisedButton(
                                  focusElevation: 1000,
                                
                                  shape: RoundedRectangleBorder(
                                    borderRadius :new BorderRadius.circular(40),
                                    side :BorderSide(color:Colors.white,width :5)
                                     
                                  ),
                                  color: Colors.blue,
                                  padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                                  child: Text(
                                    "submit",
                                    style: TextStyle(color: Colors.white, fontSize: 23),
                                  ),
                                  onPressed: () async {
                                    if (!_formKey.currentState.validate()) {
                                      return;
                                    }
                                    setState(() {
                                      loading = true;
                                    });
                                    await verifyPhone(this.phoneNo);
                                    print(this.verificationId.toString());
                                  }),
                                  
                            ),
                            
                             SizedBox(
                               child:Column(
                                   children :<Widget>[
                                     Container(
                                       child :
                                       Text("Help Stop Corona Virus", style :TextStyle(color :Colors.black,fontSize :25)),
                                     ),
                                     Container(
                                       child :
                                       Text(" STAY home.", style :TextStyle(color :Colors.black,fontSize :18)),
                                     ),
                                     Container(
                                       child :
                                       Text(" KEEP a safe distance.", style :TextStyle(color :Colors.black,fontSize :18)),
                                     ),
                                     Container(
                                       child :
                                       Text(" WASH hands often.", style :TextStyle(color :Colors.black,fontSize :18)),
                                     ),
                                    Container(
                                       child :
                                       Text(" COVER your cough.", style :TextStyle(color :Colors.black,fontSize :18)),
                                     ), 
                                      Container(
                                       child :
                                       Text(" SICK? Call the Helpline.", style :TextStyle(color :Colors.black,fontSize :18)),
                                     ), 
                                   ]
                               )
                               
                               
                             )
                          ]),
                        ),
                    ),
                    ),
                
                    );
                  }
                  else{
                    return KeyboardAvoider(
                     //  margin: EdgeInsets.fromLTRB(200, 15, 200,0 ),
               // padding: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
               autoScroll: true,
                child: SingleChildScrollView(
                controller: _scrollController,
                  child: Container(
                    padding :EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
                    margin :EdgeInsets.fromLTRB(200, 15, 200, 0),
                                      child: Form(
                      key: _formKey,

                    
                        child: Column(
                        
                      
                          children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.4,
                           // height: 120,
                            child: Image.asset('assets/images/user.png'),
                          ),
                        //  SizedBox(
                         //   height :70,
                                                     TextFormField(
                              
                             // focusNode: _focusNode,
                                textInputAction: TextInputAction.next,
                                  autofocus: true,
                                  onFieldSubmitted: (v){
                                    FocusScope.of(context).requestFocus(focus);
                                 },
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.blue,
                                  ),
                                //  errorStyle: TextStyle(
                               //     fontSize :10,
                              //    ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 5.0),
                                  ),
                                  labelText: 'Enter your name:'),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Name is Required";
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  this.name1 = val;
                                });
                              },
                            ),
                       //   ),
                          SizedBox(height: 20),
                          TextFormField(
                            maxLength: 10,
                            
                            maxLengthEnforced: true,
                              focusNode: focus,
                               textInputAction: TextInputAction.next,
                                   autofocus: true,
                                    onFieldSubmitted: (v){
                                     FocusScope.of(context).requestFocus(hocus);
                                  },
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.green,
                                ),
                                counterText: "",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5.0),
                                ),
                                labelText: 'Mobile Number'),
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Mobile Number is required";
                              }
                              else if(value.length>0&&value.length<10)
                              { 
                               
                                return "Enter a Valid 10 digit Mobile Number";
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                this.phoneNo = val;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                             focusNode: hocus,
                              textInputAction: TextInputAction.next,
                                   autofocus: true,
                                    onFieldSubmitted: (v){
                                     FocusScope.of(context).requestFocus(mocus);
                                  },
                            maxLength: 1,
                            maxLengthEnforced: true,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.streetview,
                                  color: Colors.black,
                                ),
                                counterText: "",
                                
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5.0),
                                ),
                                labelText: 'Street No'),
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                            //  if(value.isNotEmpty)
                             // {
                            //    int  nit =int.parse(value);
                            //    if(nit>5||nit==0)
                           //   {
                            //    return "Enter a Valid Street No";
                            //  }
                            //  }
                             
                              if (value.isEmpty) {
                                return "Street No is required";
                              }
                             
                            },
                            onChanged: (val) {
                              setState(() {
                               
                                this.road = val;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            focusNode: mocus,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.home,
                                  color: Colors.red,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5.0),
                                ),
                                labelText: 'Plot No'),
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Plot No is required";
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                this.plot = val;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            child: Text(
                              "please select an option",
                              style: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                          Container(
                         // decoration: BoxDecoration(border: Border.all(width :2,)),
                            color: Colors.grey[200],
                            margin :EdgeInsets.fromLTRB(0,10 , 0,10 ),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                             child: DropdownButton<String>(
                              //    focusNode: focus,
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
                                color: Colors.grey[200],
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>['RESIDENT', 'VOLUNTEER']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(bottom :20),
                                   child: RaisedButton(
                                focusElevation: 1000,
                              
                                shape: RoundedRectangleBorder(
                                  borderRadius :new BorderRadius.circular(40),
                                  side :BorderSide(color:Colors.white,width :5)
                                   
                                ),
                                color: Colors.blue,
                                padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                                child: Text(
                                  "submit",
                                  style: TextStyle(color: Colors.white, fontSize: 23),
                                ),
                                onPressed: () async {
                                  if (!_formKey.currentState.validate()) {
                                    return;
                                  }
                                  setState(() {
                                    loading = true;
                                  });
                                  await verifyPhone(this.phoneNo);
                                  print(this.verificationId.toString());
                                }),
                          ),
                        ]),
                      ),
                  ),
                  ),
                    );
                  }

                },
               
                ),
              ),
            );
          
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
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
        this.loading = false;
      });

      final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Phoneverificationpage(
                  sent: this.codeSent,
                  verificationId: this.verificationId.toString(),
                  phonenumber: this.phoneNo,
                  name: this.name1,
                  plot: this.plot,
                  road: this.road,
                  cat: this.dropdownValue)));
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      setState(() {
        this.codeSent = true;
      });
      this.verificationId = verId;
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91' + phoneNo,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verified,
          verificationFailed: verificationfailed,
          codeSent: smsSent,
          codeAutoRetrievalTimeout: autoTimeout);
    } catch (e) {
      print(e.toString());
    }
  }
}
