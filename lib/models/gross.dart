import 'package:cloud_firestore/cloud_firestore.dart';

class Gross{
  final String did;
  final String name;
  final String username;
  final String road;
  final String plot;
  final Timestamp time;

  Gross({this.did,this.name,this.username,this.road,this.plot,this.time});
}