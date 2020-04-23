import 'package:flutter/material.dart';
import 'package:prcolony/models/gross.dart';

class Expand extends StatefulWidget {

  Gross gross;
  Expand({this.gross});

  @override
  _ExpandState createState() => _ExpandState();
}

class _ExpandState extends State<Expand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.gross.username),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.gross.name),
          ),
    );
  }
}