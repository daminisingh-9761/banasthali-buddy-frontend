import 'dart:convert';
import 'dart:async'; // ✅ ADDED
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import 'dart:io';

class ApiService {

  // ===============================
  // SERVER WAKE-UP (Render sleep fix)
  // ===============================
  static Future<void> pingServer() async {
    try {
      await http.get(
        Uri.parse("https://banasthali-buddy.onrender.com"),
      ).timeout(const Duration(seconds: 10));
    } catch (e) {
      print("Ping failed: $e");
    }
  }

  // ===============================
  // LOGIN (FIXED API ONLY)
  // ===============================
  static Future<Map<String,dynamic>> login(
      String email,
      String password
      ) async {

    try {

      final response = await http.post(
        Uri.parse("https://banasthali-buddy.onrender.com/api/auth/login"), // ✅ FIXED
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "email": email,
          "password": password
        }),
      ).timeout(const Duration(seconds: 60));

      print("LOGIN STATUS: ${response.statusCode}");
      print("LOGIN BODY: ${response.body}");

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        String role = "student";

        if (data["role"] != null) {
          role = data["role"];
        } else if (data["user"] != null && data["user"]["role"] != null) {
          role = data["user"]["role"];
        }

        return {
          "success": true,
          "role": role.toLowerCase(),
          "token": data["token"],
        };

      } else {

        return {
          "success": false,
          "message": "Invalid email or password"
        };

      }

    } on TimeoutException {

      print("LOGIN TIMEOUT");

      return {
        "success": false,
        "message": "LOGIN FAILED"
      };

    } catch (e) {

      print("LOGIN ERROR: $e");

      return {
        "success": false,
        "message": "Something went wrong"
      };
    }
  }


  // ===============================
  // SIGNUP (UNCHANGED)
  // ===============================
  static Future<bool> signup(
      String name,
      String email,
      String password,
      String role,
      ) async {

    try {

      final response = await http.post(
        Uri.parse("https://banasthali-buddy.onrender.com/api/auth/register"), // ✅ FIXED
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "username": name,   // ✅ MUST
          "email": email,
          "password": password
        }),
      ).timeout(const Duration(seconds: 70));

      print("SIGNUP STATUS: ${response.statusCode}");
      print("SIGNUP BODY: ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;

    } catch (e) {

      print("SIGNUP ERROR: $e");
      return false;

    }
  }

  // ===============================
  // DRIVER ONLINE STATUS
  // ===============================
  static Future<Map<String,dynamic>> driverOnline(
      String token,
      bool isOnline
      ) async {

    final response = await http.patch(

      Uri.parse(
          "https://banasthali-buddy.onrender.com/api/driver/status"
      ),

      headers: {

        "Authorization": "Bearer $token",
        "Content-Type": "application/json"

      },

      body: jsonEncode({

        "online": isOnline

      }),

    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {

      return jsonDecode(response.body);

    } else {

      return {};

    }

  }


  // ===============================
  // UPDATE DRIVER LOCATION
  // ===============================
  static Future<void> updateLocation(
      String token,
      double lat,
      double lng
      ) async {

    await http.put(
        Uri.parse("https://banasthali-buddy.onrender.com/api/driver/location"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "latitude": lat,
          "longitude": lng
        })
    );
  }


  // ===============================
  // DRIVER BOOKINGS
  // ===============================
  static Future<List> getDriverBookings(
      String token
      ) async {

    final response = await http.get(
        Uri.parse("https://banasthali-buddy.onrender.com/api/bookings/me/driver"),
        headers: {
          "Authorization": "Bearer $token"
        }
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return []; // list return karna hai
    }
  }


  // ===============================
  // UPDATE BOOKING STATUS
  // ===============================
  static Future<void> updateBookingStatus(
      String token,
      String bookingId,
      String status
      ) async {

    await http.patch(
        Uri.parse("https://banasthali-buddy.onrender.com/api/bookings/$bookingId/status"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "status": status
        })
    );
  }


  // ===============================
  // BUS ETA
  // ===============================
  static Future<List> getBusETA(
      String token,
      String postId
      ) async {

    final response = await http.get(
        Uri.parse("https://banasthali-buddy.onrender.com/api/bus/eta/$postId"),
        headers: {
          "Authorization": "Bearer $token"
        }
    );

    return jsonDecode(response.body);
  }

  // Post item
  static Future<bool> postItem(
      String token,
      String title,
      String description,
      String price,
      String category,
      String sellerPhone,
      String sellerHostel,
      String sellerRoom,
      File? image,
      ) async {

    try {

      /// ✅ FIX: GET LATEST TOKEN FROM STORAGE
      final prefs = await SharedPreferences.getInstance();
      String? storedToken = prefs.getString("token");
      print("USING TOKEN: $storedToken"); // 🔥 DEBUG

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("https://banasthali-buddy.onrender.com/api/items"),
      );

      /// ✅ USE STORED TOKEN (fallback to param)
      request.headers["Authorization"] = "Bearer ${storedToken ?? token}";

      /// 🔹 TEXT FIELDS
      request.fields["title"] = title;
      request.fields["description"] = description;
      request.fields["price"] = price;
      request.fields["category"] = category;
      request.fields["sellerPhone"] = sellerPhone;
      request.fields["sellerHostel"] = sellerHostel;
      request.fields["sellerRoom"] = sellerRoom;
      request.fields["sold"] = "false";

      /// 🔥 IMAGE FILE
      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "image",
            image.path,
          ),
        );
      }

      var response = await request.send();
      final resBody = await response.stream.bytesToString();

      print("POST ITEM STATUS: ${response.statusCode}");
      print("POST ITEM BODY: $resBody");

      return response.statusCode == 200 ||
          response.statusCode == 201;

    } catch (e) {
      print("POST ITEM ERROR: $e");
      return false;
    }
  }

  //get item
  static Future<List> getItems() async {

    try {

      final response = await http.get(
        Uri.parse("https://banasthali-buddy.onrender.com/api/items?size=50"),
      );

      print("GET ITEMS STATUS: ${response.statusCode}");
      print("GET ITEMS BODY: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }

    } catch (e) {

      print("GET ITEMS ERROR: $e");
      return [];
    }
  }
  // getMYItems
  static Future<List> getMyItems() async {
    try {

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      final response = await http.get(
        Uri.parse("https://banasthali-buddy.onrender.com/api/items/my"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }

    } catch (e) {
      print("GET MY ITEMS ERROR: $e");
      return [];
    }
  }
  //mark as sold
  static Future<void> markItemAsSold(String id) async {
    try {

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      await http.patch(
        Uri.parse("https://banasthali-buddy.onrender.com/api/items/$id/sold"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

    } catch (e) {
      print("MARK SOLD ERROR: $e");
    }
  }
  // delete items
  static Future<void> deleteItem(String id) async {
    try {

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      await http.delete(
        Uri.parse("https://banasthali-buddy.onrender.com/api/items/$id"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

    } catch (e) {
      print("DELETE ITEM ERROR: $e");
    }
  }

  static Future<List> getAllItems() async {
    try {

      final response = await http.get(
        Uri.parse("https://banasthali-buddy.onrender.com/api/items"),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }

    } catch (e) {
      print("GET ALL ITEMS ERROR: $e");
      return [];
    }
  }

  static Future<List> searchItems(String query) async {
    try {

      final response = await http.get(
        Uri.parse("https://banasthali-buddy.onrender.com/api/items/search?query=$query"),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }

    } catch (e) {
      print("SEARCH ERROR: $e");
      return [];
    }
  }

  static Future<List> getItemsByCategory(String category) async {
    try {

      final response = await http.get(
        Uri.parse("https://banasthali-buddy.onrender.com/api/items/category/$category"),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }

    } catch (e) {
      print("CATEGORY ERROR: $e");
      return [];
    }
  }
  ///forgot password
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {

      final response = await http.post(
        Uri.parse("https://banasthali-buddy.onrender.com/api/auth/forgot-password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        return {"success": true};
      } else {
        return {"success": false, "message": "Email not found"};
      }

    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }


}