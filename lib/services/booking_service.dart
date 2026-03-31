import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class BookingService {

  Future requestRide(String pickup, String destination) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final url = Uri.parse("https://banasthali-buddy.onrender.com/api/bookings/request");

    print("TOKEN: $token");
    print("REQUEST URL: $url");

    if (token == null) {
      print("ERROR: TOKEN IS NULL - USER NOT LOGGED IN");
      return {"error": "User not logged in"};
    }

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({
        "pickupPostId": pickup,
        "destinationPostId": destination
      }),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return {"error": response.body};
    }
  }

  Future getStudentBookings() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final url = Uri.parse("https://banasthali-buddy.onrender.com/api/bookings/me/student");

    print("GET STUDENT BOOKINGS");
    print("TOKEN: $token");

    if (token == null) {
      print("ERROR: TOKEN IS NULL");
      return [];
    }

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token"
      },
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  Future getDriverBookings() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final url = Uri.parse("https://banasthali-buddy.onrender.com/api/bookings/me/driver");

    if (token == null) {
      print("ERROR: TOKEN IS NULL");
      return [];
    }

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token"
      },
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  Future acceptRide(String bookingId) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final url = Uri.parse("https://banasthali-buddy.onrender.com/api/bookings/$bookingId/status");

    if (token == null) {
      print("ERROR: TOKEN IS NULL");
      return {"error": "User not logged in"};
    }

    final response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({
        "status": "ACCEPTED"
      }),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {"error": response.body};
    }
  }
}