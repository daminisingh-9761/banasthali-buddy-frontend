import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {

  static const baseUrl =
      "https://banasthali-buddy.onrender.com/api/chat";

  // GET messages
  static Future<List> getMessages(String bookingId) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final res = await http.get(

      Uri.parse("$baseUrl/$bookingId"),

      headers: {
        "Authorization": "Bearer $token"
      },

    );

    final data = jsonDecode(res.body);

    return data is List ? data : [];
  }


  // SEND message
  static Future sendMessage(

      String bookingId,
      String senderId,
      String message

      ) async {

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final res = await http.post(

      Uri.parse("$baseUrl/send"),

      headers: {

        "Authorization": "Bearer $token",

        "Content-Type": "application/json"

      },

      body: jsonEncode({

        "bookingId": bookingId,

        "senderId": senderId,

        "message": message

      }),

    );

    print("CHAT SEND STATUS ${res.statusCode}");
    print("CHAT SEND BODY ${res.body}");

  }

}