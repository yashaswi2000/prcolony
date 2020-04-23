import 'package:flutter/material.dart';
import 'package:prcolony/services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[IconButton(icon: Icon(Icons.highlight_off), onPressed: () async{ await AuthService().signOut();})],),
    );
  }
}