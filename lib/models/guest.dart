//import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';


final DateFormat formatter = DateFormat.yMd();

const uuid = Uuid();

// create a new class for maintenance
class Guest {
  Guest({
   
   required this.name,
   required this.vehicle_NO,
   required this.date,
   required this.nic,
  }) : id = uuid.v4(); //generates a unique string identifier

  final String id;
  final String name;
  final String vehicle_NO;
  final String nic;
  final DateTime date;

  String get formattedDate {
    return formatter.format(date);
  }
}
