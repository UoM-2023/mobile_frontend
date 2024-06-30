//import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:apartflow_mobile_app/global.dart';
import 'package:http/http.dart' as http;

final DateFormat formatter = DateFormat.yMd();

const uuid = Uuid();

// create a new class for maintenance
class Support {
  Support({
    required this. id,
    required this.description,
    required this.date,
    required this.status,
    required this.title,
  }); //generates a unique string identifier

  final String id;
  final String status;
  final String title;
  final String description;
  final String date;

  factory Support.fromJson(Map<String, dynamic> json) {
    print('called support');
    return Support(
      id: uuid.v4(),
      title: json['Title'] as String? ?? 'Unknown Category',
      description: json['C_Description'] as String? ?? 'No Description',
      date: json['C_Date'] as String? ?? 'Unknown Date',
      status: json['CStatus'] as String? ?? 'Unknown Status',
      
    );
    
  }

  static Future<List<Support>> fetchSupportList(String unitID) async {
    
    final url = '${baseurl}/complaints/newComplaint_by_user_id/$unitID';
    print('Fetching support list from $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print("if called");
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['result']; 
        if (data == null || data.isEmpty) {
          print('No support data found.');
          return [];
        }
        print(data);
        List<Support> supports = data.map((json) => Support.fromJson(json)).toList();
        print('Parsed support data: $supports');
        return supports;
      } else {
        print('Failed to load support data. Status code: ${response.statusCode}');
        throw Exception('Failed to load support data');
      }
    } catch (error) {
      print('Error fetching support data: $error');
      throw Exception('Error fetching support data');
    }
  }

  

}


