import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app/models/aunthentication_model.dart';

class AuthService {
  final String baseUrl = 'http://127.0.0.1:3000'; // Replace with your backend URL

  // Signup method
  Future<bool> signup(UserModel user) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    return response.statusCode == 201;
  }

  // Login method
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];

      // Debug: Print the token
      print('Token received: $token');

      // Save the token in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      // Debug: Check if token is saved
      print('Token saved in SharedPreferences: ${prefs.getString('jwt_token')}');
      return true;
    } else {
      print('Login failed: ${response.body}');
      return false;
    }
  }

  // Get saved JWT token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    
    // Debug: Log the retrieved token
    print('Retrieved token: $token');
    return token;
  }

  // Check if the user is logged in
  Future<bool> isUserLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
