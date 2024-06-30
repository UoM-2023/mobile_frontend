import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:apartflow_mobile_app/global.dart';
import 'package:http/http.dart' as http;

final DateFormat formatter = DateFormat.yMd();
const uuid = Uuid();

class Amenity {
  Amenity({
    required this.id,
    required this.name,
    required this.amount,
    required this.chargePer,
  });

  final String id;
  final String name;
  final String amount;
  final String chargePer;
  

  factory Amenity.fromJson(Map<String, dynamic> json) {
    print('called Amenity');
    return Amenity(
      id: uuid.v4(),
      name: json['facility_name'] as String? ?? 'Unknown name',
      amount: json['amount_charge'] as String? ?? 'Unknown amount',
      chargePer: json['charge_per'] as String? ?? 'unknown',
      
    );
  }

  static Future<List<Amenity>> fetchAmenityList() async {
    final url = '$baseurl/Facility/Facilities';
    print('Fetching amenity list from $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print("if called");
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['result'];
        if (data == null || data.isEmpty) {
          print('No amenity data found.');
          return [];
        }
        print(data);
        List<Amenity> amenities = data.map((item) => Amenity.fromJson(item)).toList();
        print('Parsed amenity data: $amenities');
        return amenities;
      } else {
        print('Failed to load amenity data. Status code: ${response.statusCode}');
        throw Exception('Failed to load amenity data');
      }
    } catch (error) {
      print('Error fetching amenity data: $error');
      throw Exception('Error fetching amenity data');
    }
  }
}
