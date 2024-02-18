import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:apartflow_mobile_app/models/enum.dart';

final DateFormat formatter = DateFormat.yMd();
const Uuid uuid = Uuid();



class Reservation {
  Reservation(  {
    required this.amenityName,
    required this.startDate,
    required this.endDate,
    required this.needForHours,
    required this.time,
  }) : id = uuid.v4();

  final String id;
  final AmenityType amenityName;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay time;
  final String needForHours;

  String get formattedStartDate {
    return formatter.format(startDate);
  }

  String get formattedEndDate {
    return formatter.format(endDate);
  }
}
