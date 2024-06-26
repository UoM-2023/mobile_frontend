import 'dart:convert';
import 'package:apartflow_mobile_app/global.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat.yMd();
const uuid = Uuid();

class Maintenance {
  Maintenance({
    required this.id,
    required this.description,
    required this.date,
    required this.category,
    required this.status,
  });

  final String id;
  final String category;
  final String description;
  final String date;
  final String status;

  factory Maintenance.fromJson(Map<String, dynamic> json) {
    print('called maintenance');
    return Maintenance(
      id: json['id'].toString(),
      category: json['MType'] as String? ?? 'Unknown Category',
      description: json['M_Description'] as String? ?? 'No Description',
      date: json['requested_date'] as String? ?? 'Unknown Date',
      status: json['Mnt_Status'] as String? ?? 'Unknown Status',
    );
  }

  static Future<List<Maintenance>> fetchMaintenanceList(String _unitID) async {
    final url = '${baseurl}/maintenance/New_Mnt_Req_By_User/$_unitID';
    print('Fetching maintenance list from $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print("if called");
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['result'];
        if (data == null || data.isEmpty) {
          print('No maintenance data found.');
          return [];
        }
        print(data);
        List<Maintenance> maintenances = data.map((json) => Maintenance.fromJson(json)).toList();
        print('Parsed maintenance data: $maintenances');
        return maintenances;
      } else {
        print('Failed to load maintenance data. Status code: ${response.statusCode}');
        throw Exception('Failed to load maintenance data');
      }
    } catch (error) {
      print('Error fetching maintenance data: $error');
      throw Exception('Error fetching maintenance data');
    }
  }
}
