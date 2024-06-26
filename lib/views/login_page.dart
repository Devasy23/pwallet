import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/api_service.dart';
import 'dashboard_page.dart';

enum AuthMode { login, register }

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.login;
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    setState(() {
      _authMode = _authMode == AuthMode.login ? AuthMode.register : AuthMode.login;
    });
  }

  void _submit() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    try {
      if (_authMode == AuthMode.login) { // Handling login
        final response = await _apiService.loginUser(username, password);
        if (response['message'] == 'User authenticated successfully') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardPage()));
        } else {
          _showDialog('Login Failed', 'Invalid credentials or server error.');
        }
      } else { // Handling registration
        final response = await _apiService.registerUser(username, password);
        if (response['message'] == 'User registered successfully') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardPage()));
        } else {
          _showDialog('Registration Failed', 'Failed to register user or server error.');
        }
      }
    } catch (e) {
      _showDialog('Error', e.toString());
    }
  }

  void _showDialog(String title, String message) {
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

  @override
  Widget build(BuildContext context) {
    final isLoginMode = _authMode == AuthMode.login;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(size: 120),
                SizedBox(height: 24),
                Text(
                  isLoginMode ? 'Welcome Back' : 'Create Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      // TODO: Implement Forgot Password feature
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    elevation: 2,
                    shadowColor: primaryColor.withOpacity(0.2),
                  ),
                  child: Text(isLoginMode ? 'Login' : 'Register'),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Placeholder for "Login with Google" implementation
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // Button text color
                    backgroundColor: Colors.blueAccent, // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text('Login with Google'),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      isLoginMode ? 'Don’t have an account?' : 'Already have an account?',
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: _toggleAuthMode,
                      child: Text(
                        isLoginMode ? 'Register' : 'Login',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
