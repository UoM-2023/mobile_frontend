import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.1.102:3001/auth'; // Replace with your backend URL

  Future<void> login(String userId, String password) async {
  final url = Uri.parse('$baseUrl/login');

  final Map<String, String> body = {
    'userID': userId,
    'password': password,
  };

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  print('Request Body: $body');

  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(body),
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data.containsKey('token')) {
      // Parse the token and extract user information if needed
      return;
    } else {
      throw Exception('Invalid response from server');
    }
  } else {
    throw Exception('Failed to login: ${response.body}');
  }
}




  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        await prefs.remove('token');
        await prefs.remove('UserId');
      } else {
        throw Exception('Failed to logout: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to logout: $e');
    }
  }

  Future<void> refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse('$baseUrl/refresh'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await prefs.setString('token', data['token']);
        String userIdFromToken = JwtDecoder.decode(data['token'])['UserId'];
        await prefs.setString('userId', userIdFromToken);
      } else {
        throw Exception('Failed to refresh token: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to refresh token: $e');
    }
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
}
