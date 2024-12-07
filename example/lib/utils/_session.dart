import 'dart:convert';

import 'package:arcore_flutter_plugin_example/constants/_savedUser.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionAccess {
  static SessionAccess instance = SessionAccess._constructor();
  static _SessionNames names = _SessionNames();
  SessionAccess._constructor();

  Future<bool> storeSessionToken({
    required String sessionName,
    String? token,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) {
      await prefs.setString(sessionName, token);
      return true;
    }
    return false;
  }

  Future<String?> getSessionToken({required String sessionName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sessionName) ?? null;
  }

  void deleteSessionToken({required String sessionName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(sessionName);
  }

  Future<void> storeUserData(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(names.SESSION_USER_DATA, jsonEncode(user.toJson()));
    CURRENT_USER.value = user;
  }

  Future<UserModel?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString(names.SESSION_USER_DATA);
    if (userData != null) {
      return UserModel.fromJson(jsonDecode(userData));
    }
    return null;
  }

  void deleteUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(names.SESSION_USER_DATA);
  }
}

class _SessionNames {
  String SESSION_LOGIN = 'login_token';
  String SESSION_FIRST_RUN = 'first_run_token';
  String SESSION_USER_DATA = 'user_data';
}
