// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:apartflow_mobile_app/models/maintenance.dart';

// class MaintenanceService {
//   static const String _baseUrl = 'http://169.254.16.21:3001';

//   Future<List<Maintenance>> fetchMaintenanceItems() async {
//     final response = await http.get(Uri.parse('$_baseUrl/maintenance/New_Mnt_Req'));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((json) => Maintenance.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load maintenance items');
//     }
//   }
// }
