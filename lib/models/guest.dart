import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:apartflow_mobile_app/global.dart';
import 'package:http/http.dart' as http;

final DateFormat formatter = DateFormat.yMd();
const uuid = Uuid();

class Guest {
  Guest({
    required this.id,
    required this.name,
    required this.vehicle_NO,
    required this.date,
    required this.nic,
  });

  final String id;
  final String name;
  final String vehicle_NO;
  final String nic;
  final DateTime date;

  factory Guest.fromJson(Map<String, dynamic> json) {
    print('called Guest');
    return Guest(
      id: uuid.v4(),
      name: json['guest_name'] as String? ?? 'Unknown name',
      nic: json['guest_NIC'] as String? ?? 'Unknown nic',
      vehicle_NO: json['vehicle_number'] as String? ?? 'No vehicle No',
      date: json['arrival_date'] != null 
        ? DateTime.parse(json['arrival_date']) 
        : DateTime.now(),
    );
  }

  static Future<List<Guest>> fetchGuestList(String unitID) async {
    final url = 'http://$baseurl/GuestDetail/GuestDetails_by_unit/$unitID';
    print('Fetching guest list from $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print("if called");
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['result'];
        if (data == null || data.isEmpty) {
          print('No guest data found.');
          return [];
        }
        print(data);
        List<Guest> guests = data.map((item) => Guest.fromJson(item)).toList();
        print('Parsed guest data: $guests');
        return guests;
      } else {
        print('Failed to load guest data. Status code: ${response.statusCode}');
        throw Exception('Failed to load guest data');
      }
    } catch (error) {
      print('Error fetching guest data: $error');
      throw Exception('Error fetching guest data');
    }
  }
}
