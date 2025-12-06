import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_url.dart';
import 'user_info.dart';

class Api {
  // ================= LOGIN =================
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiUrl.login),
      body: {
        "email": email,
        "password": password,
      },
    );

    print("RAW LOGIN = ${response.body}");

    final res = jsonDecode(response.body);

    if (res is Map<String, dynamic>) {
      return res;
    } else {
      throw Exception("Response login tidak valid");
    }
  }

  // ================= REGISTRASI =================
  static Future<Map<String, dynamic>> registrasi(
      String nama, String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiUrl.registrasi),
      body: {
        "nama": nama,
        "email": email,
        "password": password,
      },
    );

    print("RAW REGISTRASI = ${response.body}");

    final res = jsonDecode(response.body);

    if (res is Map<String, dynamic>) {
      return res;
    } else {
      throw Exception("Response registrasi tidak valid");
    }
  }

  // ================= GET INVENTARIS =================
  static Future<List> getInventaris() async {
    final headers = await UserInfo.getTokenHeader();

    print("HEADER = $headers");

    final response = await http.get(
      Uri.parse(ApiUrl.inventaris),
      headers: headers,
    );

    print("STATUS = ${response.statusCode}");
    print("RAW INVENTARIS = ${response.body}");

    final res = jsonDecode(response.body);

    // ✅ VALIDASI WAJIB
    if (res is Map && res["status"] == true && res["data"] is List) {
      return res["data"];
    } else {
      throw Exception(res["data"] ?? "Gagal mengambil data inventaris");
    }
  }

  // ================= TAMBAH INVENTARIS =================
  static Future<Map<String, dynamic>> tambahInventaris(
      Map<String, dynamic> body) async {
    final headers = await UserInfo.getTokenHeader();

    final response = await http.post(
      Uri.parse(ApiUrl.inventaris),
      headers: headers,
      body: body,
    );

    print("STATUS TAMBAH = ${response.statusCode}");
    print("RAW TAMBAH = ${response.body}");

    final res = jsonDecode(response.body);

    if (res is Map<String, dynamic>) {
      return res;
    } else {
      throw Exception("Response tambah inventaris tidak valid");
    }
  }

  // ================= HAPUS INVENTARIS =================
  static Future<Map<String, dynamic>> hapusInventaris(int id) async {
    final headers = await UserInfo.getTokenHeader();

    final response = await http.delete(
      Uri.parse(ApiUrl.inventarisById(id)),
      headers: headers,
    );

    print("STATUS HAPUS = ${response.statusCode}");
    print("RAW HAPUS = ${response.body}");

    final res = jsonDecode(response.body);

    if (res is Map<String, dynamic>) {
      return res;
    } else {
      throw Exception("Response hapus inventaris tidak valid");
    }
  }

  // ================= UPDATE INVENTARIS =================
  static Future<Map<String, dynamic>> updateInventaris(
      int id, Map<String, dynamic> body) async {
    final headers = await UserInfo.getTokenHeader();

    final response = await http.put(
      Uri.parse(ApiUrl.inventarisById(id)),
      headers: headers,
      body: body,
    );

    print("STATUS UPDATE = ${response.statusCode}");
    print("RAW UPDATE = ${response.body}");

    final res = jsonDecode(response.body);

    if (res is Map<String, dynamic>) {
      return res;
    } else {
      throw Exception("Response update inventaris tidak valid");
    }
  }
}
