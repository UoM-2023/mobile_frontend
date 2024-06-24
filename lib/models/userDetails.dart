import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String userId;
  final String unitId;
  final String residentId;
  final String first_name;
  final String last_name;
  final String dob;
  final String nic;
  final String memberType;
  final String email;
  final String mobileNo;
  final String address;

  User({
    required this.userId,
    required this.unitId,
    required this.residentId,
    required this.first_name,
    required this.last_name,
    required this.dob,
    required this.nic,
    required this.memberType,
    required this.email,
    required this.mobileNo,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['UserName'],
      unitId: json['UnitID'],
      residentId: json['residentID'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      dob: json['dob'],
      nic: json['nic'],
      memberType: json['member_type'],
      email: json['email'],
      mobileNo: json['mobile_no'],
      address: json['Address'],
    );
  }

  static Future<User> fetchUserDetails(String userId) async {
    print("User Id called to user details: $userId");
    // final url = 'http://192.168.8.102:3001/residentsDetails/getResidentInfo/$userId';
    // print("URL: $url");
    try {
      final response = await http.get(
      Uri.parse('https://e8ba-2402-4000-21c2-e188-ad0b-f674-765d-4395.ngrok-free.app/residentsDetails/getResidentInfo/$userId')
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['result'][0];
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user details');
    }
    } catch (error) {
      print('Failed to load user details: $error');
      throw Exception('Failed to load user details $error');
    }
    
  }
}
