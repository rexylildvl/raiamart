import '../helpers/api.dart';
import '../helpers/user_info.dart';
import '../model/login.dart';
import 'package:flutter/material.dart';

class LoginBloc {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<Map<String, dynamic>> login(String email, String password) async {
    isLoading.value = true;

    final res = await Api.login(email, password);
    isLoading.value = false;
    print("RESPON LOGIN = $res");
    print("DATA = ${res["data"]}");

    if (res["status"] == true) {
      final data = res["data"];
      LoginModel user = LoginModel.fromJson(data);

      await UserInfo.saveToken(user.token!);
      await UserInfo.saveUser(user);

      return {
        "success": true,
        "message": "Login berhasil",
        "user": user,
      };
    } else {
      return {
        "success": false,
        "message": res["data"],
      };
    }
  }
}
