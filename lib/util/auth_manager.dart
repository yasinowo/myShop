import 'package:aplle_shop_pj/di/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authNotifire = ValueNotifier(null);
  static final SharedPreferences sharedPreferences = locator.get();
  static saveToken(String token) async {
    sharedPreferences.setString('access_token', token);

    authNotifire.value = token;
  }

  static String readAuth() {
    return sharedPreferences.getString('access_token') ?? '';
  }

  static logout() {
    sharedPreferences.clear();
    authNotifire.value = null;
  }

  static saveId(String id) async {
    sharedPreferences.setString('user_id', id);
  }

  static String getId() {
    return sharedPreferences.getString('user_id') ?? '';
  }
}
