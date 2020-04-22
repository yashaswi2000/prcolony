import 'package:flutter/material.dart';

void main() {
  runApp(SignUp());
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String name,phone,plot,road,volunteer;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Signup page",
            textAlign: TextAlign.center,
          ),
        ),
        resizeToAvoidBottomPadding: false,
        body: Container(
          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: SingleChildScrollView(
            child:  Form(
                          child: Column(children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5.0),
                      ),
                      labelText: 'Enter your name:'),
                      onChanged: (val) {
                          setState(() {
                            this.name = val;
                          });
                      },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5.0),
                      ),
                      labelText: 'Mobile Number'),
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      this.phone = val;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.streetview,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5.0),
                      ),
                      labelText: 'Street No'),
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      this.road=val;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.home,
                        color: Colors.red,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5.0),
                      ),
                      labelText: 'Plot No'),
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      this.plot=val;
                    });
                  },
                ),
                SizedBox(height: 10),
                RaisedButton(
                    color: Colors.blue,
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                    child: Text(
                      "submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      
                    }),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
