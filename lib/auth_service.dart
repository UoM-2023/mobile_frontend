import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  static const String baseUrl = 'http://169.254.215.55:3001/auth'; // Replace with your backend URL

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

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String? token = data['token'];
        String? userIdFromResponse = data['userId'];
        
        if (token != null && userIdFromResponse != null) {
          await _saveToken(token, userIdFromResponse);
        } else {
          throw Exception('Token or userId is null');
        }
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      print('Error during login: $e');
      throw Exception('Failed to login: $e');
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
        await prefs.remove('userId');
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
        String? newToken = data['token'];
        if (newToken != null) {
          await prefs.setString('token', newToken);
          String userIdFromToken = JwtDecoder.decode(newToken)['userId'];
          await prefs.setString('userId', userIdFromToken);
        } else {
          throw Exception('New token is null');
        }
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

  Future<void> _saveToken(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('userId', userId);
  }
}
