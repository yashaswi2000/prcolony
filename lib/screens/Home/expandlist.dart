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
              child: SelectableText(
                widget.gross.name,
                style: TextStyle(
                  fontSize: 25.0,
                  height: 1.5
                ),
                cursorColor: Colors.red,
                  showCursor: true,
                  toolbarOptions: ToolbarOptions(
                  copy: true,
                  selectAll: true,
                  cut: false,
                  paste: false
                  ),
                ),
            ),
          
    );
  }
}