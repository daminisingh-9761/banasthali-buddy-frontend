import 'package:shared_preferences/shared_preferences.dart';

class TokenService {

  static const key = "token";

  static Future saveToken(String token) async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      key,
      token,
    );
  }

  static Future<String?> getToken() async {

    final prefs =
    await SharedPreferences.getInstance();

    return prefs.getString(key);
  }
}