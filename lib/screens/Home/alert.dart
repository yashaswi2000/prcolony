import 'package:flutter/material.dart';

class Alerter extends StatefulWidget {

  @override
  _AlerterState createState() => _AlerterState();
}

class _AlerterState extends State<Alerter> {
  String price = '';

  @override
  Widget build(BuildContext context) {

  // set up the AlertDialog
  return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: AlertDialog(
        backgroundColor: Colors.white,
      title: Text("Enter Price"),
      content: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    //borderRadius: BorderRadius.circular(50),
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 5.0),
                                  ),
                                  labelText: 'Enter Price'),
                              keyboardType: TextInputType.number,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Price is required";
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  this.price = val;
                                });
                              },
                            ),
      actions: [
         
        FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context,price);
       },
    ),
      ],
    ),
  );

  // show the dialog
  }
}