import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://peculiar-kaitlin-devasy.koyeb.app/';
  
  // Method for user login
  static Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      var url = Uri.parse('$_baseUrl/api/v1/user/login');
      var response = await http.post(url, body: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        return {'isSuccess': true, 'data': json.decode(response.body)};
      } else {
        return {'isSuccess': false, 'message': 'Invalid credentials'};
      }
    } catch (e) {
      return {'isSuccess': false, 'message': 'An error occurred: $e'};
    }
  }

  // Method for user registration
  static Future<Map<String, dynamic>> signUp(String username, String password) async {
    try {
      var url = Uri.parse('$_baseUrl/api/v1/user/register');
      var response = await http.post(url, body: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        return {'isSuccess': true, 'data': json.decode(response.body)};
      } else {
        return {'isSuccess': false, 'message': 'Error during registration'};
      }
    } catch (e) {
      return {'isSuccess': false, 'message': 'An error occurred: $e'};
    }
  }

  // Additional methods for other API interactions can be added here
}
