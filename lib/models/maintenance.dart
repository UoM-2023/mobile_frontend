


import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // this package use to generate unique identifiers
import 'package:intl/intl.dart';// this package use here to set data as human readable

final formatter= DateFormat.yMd();

const uuid=Uuid();

enum Category{
  Plumbing,
  Electrical,
  HVAC,
  Appliances,
  General_Maintenance,
  Pest_Control,
  Safety_and_Security,
  Grounds_keeping,
  Structural_Repairs, hintText,
  
}

const categoryText ={
  Category.Plumbing: Text("Plumbing"),
  Category.Electrical: Text("Electrical"),
  Category.HVAC:Text("HVAC"),
  Category.Appliances: Text("Appliances"),
  Category.General_Maintenance: Text("General Maintenance"),
  Category.Pest_Control: Text("Pest Control"),
  Category.Safety_and_Security: Text("Safety and Security"),
  Category.Grounds_keeping: Text("Grounds keeping"),
  Category.Structural_Repairs: Text("Structural Repairs"),

};

// create a new class for maintenance
class Maintenance{
Maintenance({

required this.description,
required this.date,
required this.category,
}) : id= uuid.v4();//generates a unique string identifier


final String id;
final Category category;
final String description;
final DateTime date;


String get formattedDate{
  return formatter.format(date);
}

}