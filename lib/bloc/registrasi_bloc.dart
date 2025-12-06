import 'package:flutter/material.dart';
import '../helpers/api.dart';
import '../model/registrasi.dart';

class RegistrasiBloc {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<Map<String, dynamic>> registrasi(
      String nama, String email, String password) async
  {
    isLoading.value = true;

    final response = await Api.registrasi(nama, email, password);

    isLoading.value = false;

    if (response["status"] == true) {
      return {
        "success": true,
        "message": response["data"],
      };
    } else {
      return {
        "success": false,
        "message": response["data"],
      };
    }
  }
}
