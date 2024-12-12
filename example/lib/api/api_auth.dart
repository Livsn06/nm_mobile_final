import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/data_model/md_login.dart';
import '../models/data_model/md_user.dart';
import '../utils/_session.dart';

class AuthenticationApi {
  static final auth = AuthenticationApi();
  static String base = dotenv.env['API_BASE']!;
  // "message": "Login successful",
  //   "access_token": "1|yhRpWjpixotHVVD3NOa7Tqyiq1dPpvYF3nhRwk2W6c00f696",
  //   "data": {
  //       "id": 1,
  //       "name": "Joel Gutlay",
  //       "email": "jo@email.com",
  //       "email_verified_at": null,
  //       "role": "admin",
  //       "status": "active",
  //       "avatar": null,
  //       "phone": null,
  //       "address": null,
  //       "created_at": "2024-12-03T05:34:23.000000Z",
  //       "updated_at": "2024-12-03T05:34:23.000000Z"
  //   }

  Future<dynamic> login(UserModel user) async {
    String url = '$base/api/auth/login';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true'
        },
        body: user.loginToJson(),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log(result.toString(), name: 'LOGIN USER API: ${response.statusCode}');

        //
        return UserModel.fromJson(
          result['data'],
          accessToken: result['access_token'],
        );
      }

      if (response.statusCode == 422) {
        var result = jsonDecode(response.body);
        log(result.toString(), name: 'LOGIN USER API: ${response.statusCode}');

        return result['message'].toString();
      }
    } catch (e) {
      log(e.toString(), name: 'CLIENT API LOGIN ERROR');
    }
    return 'Cannot connect to server';
  }

  //

  Future<String> register(UserModel user) async {
    String url = '$base/api/auth/register';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true'
        },
        body: user.registerToJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = jsonDecode(response.body);
        log(result.toString(),
            name: 'REGISTER USER API: ${response.statusCode}');

        //
        return result['message'].toString();
      }

      if (response.statusCode == 422) {
        var result = jsonDecode(response.body);
        log(result.toString(),
            name: 'REGISTER USER API: ${response.statusCode}');

        return result['message'].toString();
      }
    } catch (e) {
      log(e.toString(), name: 'CLIENT API REGISTER ERROR');
    }
    return 'Cannot connect to server';
  }

  //
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

  //
  Future<bool> logoutAccount() async {
    String url = '$base/api/auth/logout';
    String? token = await SessionAccess.instance.getSessionToken(
      sessionName: SessionAccess.names.SESSION_LOGIN,
    );

    //
    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        log('LOGOUT successful', name: 'API LOGOUT');
        return true;
      }

      return false;

      //
    } catch (e) {
      log(e.toString(), name: 'API LOGOUT');
      return false;
    }
  }
}
