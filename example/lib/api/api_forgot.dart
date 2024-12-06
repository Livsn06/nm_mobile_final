import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/data_model/md_login.dart';
import '../models/data_model/md_user.dart';

class ForgotPasswordApi {
  static final auth = ForgotPasswordApi();
  static String base = dotenv.env['API_BASE']!;
  Future<UserModel?> searchEmail(LoginModel credentials) async {
    String url = '$base/api/auth/searchEmail';
    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true'
    };

    var body = credentials.toJson();

    try {
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Searching Email successful', name: 'API SEARCH EMAIL');
        // return ResponseModel.fromEmailOnlyJson(data, success: true);
      }

      if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        return null;
      }

      if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        return null;
      }
      return null;
    } catch (e) {
      Get.close(1);
      log(e.toString(), name: 'API SEARCH EMAIL');
    }
    return null;
  }
}
