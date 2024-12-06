import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/data_model/md_user.dart';

class ApiUser {
  static String base = dotenv.env['API_BASE'] ?? '';
  static Future<List<UserModel>?> fetchAllUser() async {
    String url = '$base/api/v1/users';
    // String? token = await SessionAccess.instance.getSessionToken();

    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      // 'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      //
      if (response.statusCode == 200) {
        log('User fetched successfully', name: 'API ALL USER');
        final result = jsonDecode(response.body);
        return UserModel.listFromJson(result['data']);
      }

      log(response.statusCode.toString(), name: 'API ALL USER ERROR');
      final result = jsonDecode(response.body);
      return null;

      //
    } catch (e) {
      log(e.toString(), name: 'API ALL USER CLIENT ERROR');
    }
    return null;
  }
}
