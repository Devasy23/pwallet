import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:http/http.dart' as http;

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}

class ApiService {
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<Map<String, dynamic>> loginUser(String username, String password) async {
    if (await _connectivityService.isConnected()) {
      final response = await http.post(
        Uri.parse(ApiConstants.loginUrl.trim()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to login user');
      }
    } else {
      throw Exception('No internet connection');
    }
  }


  Future<Map<String, dynamic>> registerUser(String username, String password) async {
    if (await _connectivityService.isConnected()){

      final response = await http.post(
        //Uri.parse(ApiConstants.loginUrl.trim()),
        Uri.parse(ApiConstants.registerUrl.trim()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to register user');
      }
    }
    else {
      throw Exception('No internet connection');
    }
  }
}
