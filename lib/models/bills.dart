import 'dart:convert';
import 'package:apartflow_mobile_app/global.dart';
import 'package:http/http.dart' as http;

class Finance {
  Finance({
    required this.id,
    required this.utilityBalance,
    required this.sinkingBalance,
    required this.managementBalance,
  });

  final String id;
  final double utilityBalance;
  final double sinkingBalance;
  final double managementBalance;

  factory Finance.fromJson(Map<String, dynamic> json) {
    return Finance(
      id: json['unit_id'],
      utilityBalance: (json['utility_balance'] as num).toDouble(),
      sinkingBalance: (json['sinking_balance'] as num).toDouble(),
      managementBalance: (json['management_balance'] as num).toDouble(),
    );
  }

  static Future<Finance> fetchFinanceData(String unitID) async {
    final url = '${baseurl}/finance/getAUserCharge/$unitID';
    print('Fetching finance data from $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> result = jsonResponse['result'];
        if (result.isNotEmpty) {
          return Finance.fromJson(result[0]);
        } else {
          throw Exception('No data found in the response');
        }
      } else {
        print('Failed to load finance data. Status code: ${response.statusCode}');
        throw Exception('Failed to load finance data');
      }
    } catch (error) {
      print('Error fetching finance data: $error');
      throw Exception('Error fetching finance data');
    }
  }
}
