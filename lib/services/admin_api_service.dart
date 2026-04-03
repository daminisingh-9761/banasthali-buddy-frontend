import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminApiService {

  static const String baseUrl =
      "https://banasthali-buddy.onrender.com/api/admin";

  /// ================= GET TOKEN =================
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    print("ADMIN TOKEN: $token");

    return token;
  }

  /// ================= DASHBOARD =================
  static Future<Map<String, dynamic>> getDashboardStats() async {

    final token = await getToken();

    if (token == null || token.isEmpty) {
      print("ERROR: Token missing");
      return {};
    }

    final response = await http.get(
      Uri.parse("$baseUrl/dashboard"),
      headers: {
        "Authorization": "Bearer $token"
      },
    );

    print("DASHBOARD STATUS: ${response.statusCode}");
    print("DASHBOARD BODY: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("ERROR: ${response.body}");
      return {};
    }
  }

  /// ================= USERS LIST =================
  static Future<List<dynamic>> getUsers() async {

    final token = await getToken();

    if (token == null || token.isEmpty) {
      print("ERROR: Token missing");
      return [];
    }

    final response = await http.get(
      Uri.parse("$baseUrl/users"),
      headers: {
        "Authorization": "Bearer $token"
      },
    );

    print("USERS STATUS: ${response.statusCode}");
    print("USERS BODY: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("ERROR: ${response.body}");
      return [];
    }
  }

  /// ================= DELETE USER =================
  static Future<bool> deleteUser(String id) async {

    final token = await getToken();

    if (token == null || token.isEmpty) {
      print("ERROR: Token missing");
      return false;
    }

    final response = await http.delete(
      Uri.parse("$baseUrl/users/$id"),
      headers: {
        "Authorization": "Bearer $token"
      },
    );

    print("DELETE USER STATUS: ${response.statusCode}");

    return response.statusCode == 200;
  }

  /// ================= ROUTES LIST =================
  static Future<List<dynamic>> getRoutes() async {

    final token = await getToken();

    if (token == null || token.isEmpty) {
      print("ERROR: Token missing");
      return [];
    }

    final response = await http.get(
      Uri.parse("$baseUrl/routes"),
      headers: {
        "Authorization": "Bearer $token"
      },
    );

    print("ROUTES STATUS: ${response.statusCode}");
    print("ROUTES BODY: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("ERROR: ${response.body}");
      return [];
    }
  }

  /// ================= DELETE ROUTE =================
  static Future<bool> deleteRoute(String id) async {

    final token = await getToken();

    if (token == null || token.isEmpty) {
      print("ERROR: Token missing");
      return false;
    }

    final response = await http.delete(
      Uri.parse("$baseUrl/routes/$id"),
      headers: {
        "Authorization": "Bearer $token"
      },
    );

    print("DELETE ROUTE STATUS: ${response.statusCode}");

    return response.statusCode == 200;
  }
}