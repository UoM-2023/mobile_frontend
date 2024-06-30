
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:apartflow_mobile_app/global.dart';
import 'package:http/http.dart' as http;

final DateFormat formatter = DateFormat.yMd();
const Uuid uuid = Uuid();



class Reservation {
  Reservation(  {
    required this.id,
    required this.amenityName,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  final String id;
  final String amenityName;
  final DateTime startDate;
  final DateTime endDate;
  final String status;


  factory Reservation.fromJson(Map<String, dynamic> json) {
    print('called Reservation');
    return Reservation(
      id: uuid.v4(),
      amenityName: json['facility_name'] as String? ?? 'Unknown type',
      startDate: json['start_date'] != null 
        ? DateTime.parse(json['start_date']) 
        : DateTime.now(),
      endDate: json['end_date'] != null 
        ? DateTime.parse(json['end_date']) 
        : DateTime.now(),
      status: json['availability'] as String? ?? 'Unknown status',
        
    );
  }
  static Future<List<Reservation>> fetchReservationList(String unitID) async {
    final url = '$baseurl/Reservation/Reservations_by_user/$unitID';
    print('Fetching reservation list from $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print("if called");
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['result'];
        if (data == null || data.isEmpty) {
          print('No reservation data found.');
          return [];
        }
        print(data);
        List<Reservation> reservations = data.map((item) => Reservation.fromJson(item)).toList();
        print('Parsed reservation data: $reservations');
        return reservations;
      } else {
        print('Failed to load reservation data. Status code: ${response.statusCode}');
        throw Exception('Failed to load reservation data');
      }
    } catch (error) {
      print('Error fetching reservation data: $error');
      throw Exception('Error fetching reservation data');
    }
  }
}
