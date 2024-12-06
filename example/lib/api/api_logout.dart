import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LogoutApi {
  static final auth = LogoutApi();
  String base = dotenv.env['API_BASE']!;
  Future<void> logoutAccount() async {
    String url = '$base/api/v1/users/logout';
    // String? token = await SessionAccess.instance.getSessionToken();

    //
    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      // 'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('LOGOUT successful', name: 'API LOGOUT');
        // return ResponseModel.fromEmailOnlyJson(data, success: true);
        return;
      }

      if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        return;
      }

      if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        return;
      }
      return null;
    } catch (e) {
      Get.close(1);
      log(e.toString(), name: 'API LOGOUT');
    }
    return;
  }
}
