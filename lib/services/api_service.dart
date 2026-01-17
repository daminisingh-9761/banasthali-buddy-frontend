import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://banasthali-buddy.onrender.com";

  // ================= SIGNUP =================
  Future<bool> signup(String name, String email, String password) async {
    try {
      final response = await http
          .post(
        Uri.parse("$baseUrl/api/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": name.trim(),
          "email": email.trim(),
          "password": password.trim(),
        }),

      )
          .timeout(const Duration(seconds: 40));

      print("SIGNUP STATUS: ${response.statusCode}");
      print("SIGNUP BODY: ${response.body}");

      // ANY 2xx = SUCCESS
      return response.statusCode == 200 && response.statusCode == 201;
    } catch (e) {
      print("SIGNUP ERROR: $e");
      return false;
    }
  }

  // ================= LOGIN =================
  Future<bool> login(String email, String password) async {
    try {
      final response = await http
          .post(
        Uri.parse("$baseUrl/api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      )
          .timeout(const Duration(seconds: 40));

      print("LOGIN STATUS: ${response.statusCode}");
      print("LOGIN BODY: ${response.body}");

      // ANY 2xx = SUCCESS
      return response.statusCode == 200;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return false;
    }
  }
}
