import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminApiService {

  static const String baseUrl =
      "https://banasthali-buddy.onrender.com";

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
      Uri.parse("$baseUrl/api/admin/stats"),
      headers: {
        "Authorization": "Bearer $token"
      },
    );

    print("DASHBOARD STATUS: ${response.statusCode}");
    print("DASHBOARD BODY: ${response.body}");

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return {
        "students": data["totalUsers"] ?? 0,
        "drivers": data["totalDrivers"] ?? 0,
        "activeRides": 0,
        "listings": data["totalItems"] ?? 0
      };

    } else {

      return {
        "students": 0,
        "drivers": 0,
        "activeRides": 0,
        "listings": 0,
      };

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
      Uri.parse("$baseUrl/api/admin/users"),
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
      Uri.parse("$baseUrl/api/admin/user/$id"),
      headers: {
        "Authorization": "Bearer $token"
      },
    );

    print("DELETE USER STATUS: ${response.statusCode}");

    return response.statusCode == 200;
  }

  /// ================= ITEMS LIST (instead of routes) =================
  static Future<List<dynamic>> getRoutes() async {

    final token = await getToken();

    if (token == null || token.isEmpty) {
      print("ERROR: Token missing");
      return [];
    }

    final response = await http.get(
      Uri.parse("$baseUrl/api/admin/items"),
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

  /// ================= DELETE ITEM =================
  static Future<bool> deleteRoute(String id) async {

    final token = await getToken();

    if (token == null || token.isEmpty) {
      print("ERROR: Token missing");
      return false;
    }

    final response = await http.delete(
      Uri.parse("$baseUrl/api/admin/item/$id"),
      headers: {
        "Authorization": "Bearer $token"
      },
    );

    print("DELETE ROUTE STATUS: ${response.statusCode}");

    return response.statusCode == 200;
  }

}