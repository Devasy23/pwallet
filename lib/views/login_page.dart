import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dashboard_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> { 
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                focusNode: _usernameFocusNode,
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                focusNode: _passwordFocusNode,
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  // Clear focus before navigating
                  _usernameFocusNode.unfocus();
                  _passwordFocusNode.unfocus();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Register Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    // Clear focus when attempting login
    _usernameFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    try {
      final response = await _apiService.loginUser(
        _usernameController.text,
        _passwordController.text,
      );
      if (response['message'] == 'User authenticated successfully') {
        // Store token and user data as needed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        _showDialog(context, 'Login Failed', 'Invalid credentials or server error.');
      }
    } catch (e) {
      _showDialog(context, 'Login Error', e.toString());
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
