import 'package:shared_preferences/shared_preferences.dart';
import '../model/login.dart';

class UserInfo {

  static Future saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  static Future saveUser(LoginModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("user_id", user.id!);
    prefs.setString("user_nama", user.nama!);
    prefs.setString("user_email", user.email!);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static Future<Map<String, String>> getTokenHeader() async {
    String? token = await getToken();
    return {
      "Authorization": "Bearer $token",
    };
  }

  static Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("user_id");
    await prefs.remove("user_nama");
    await prefs.remove("user_email");
  }
}
