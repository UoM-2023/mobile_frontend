//import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:apartflow_mobile_app/models/enum.dart';

final DateFormat formatter = DateFormat.yMd();

const uuid = Uuid();

// create a new class for maintenance
class Support {
  Support({
    required this.description,
    required this.date,
    required this.Supportcategory,
  }) : id = uuid.v4(); //generates a unique string identifier

  final String id;
  final SupportCategory Supportcategory;
  final String description;
  final DateTime date;

  String get formattedDate {
    return formatter.format(date);
  }
}
