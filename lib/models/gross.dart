import 'package:cloud_firestore/cloud_firestore.dart';

class Gross{
  final String did;
  final String name;
  final String username;
  final String road;
  final String plot;
  final Timestamp time;
  final String phone;
  final String price;
  final bool done;
  final String sentuser;
  final String sentphone;
  final String uid;
  final bool paid;
  final bool delivery;
  final String devname;
  final String devphone;

  Gross({this.did,this.name,this.username,this.road,this.plot,this.time,this.phone,this.price,this.done,this.sentphone,this.sentuser,this.uid,this.paid,this.delivery,this.devname,this.devphone});
}