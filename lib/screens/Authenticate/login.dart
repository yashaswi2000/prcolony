import 'package:flutter/material.dart';
void main()
{
  runApp(Login());
}
class Login extends StatefulWidget {

  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
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
TextFormField(
  decoration: InputDecoration(
    icon : Icon(Icons.phone,
                 color: Colors.green,
               ),
     border:OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red,
                              width: 5.0),
                        ) ,
   
    labelText: 'mobile number:'
  ),
   keyboardType: TextInputType.number,
            
),
SizedBox(
  height:20
),
RaisedButton(
    color :Colors.blue,
            child : Text("login",style: TextStyle(color: Colors.white,fontSize: 18),),onPressed:(){
              setState(() {
                
              });
            },
               
            ),
           ]
        )
       )
    ),);
  }
}