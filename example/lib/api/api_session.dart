import 'dart:convert';
import 'dart:developer';

import 'package:arcore_flutter_plugin_example/models/data_model/md_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SessionApi {
  String base = dotenv.env['API_BASE']!;
  static final auth = SessionApi();

  Future<dynamic> session({required String token}) async {
    String url = '$base/api/v1/users/sessions';
    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        log('Session confirmed', name: 'API SESSION');
        final data = jsonDecode(response.body);

        return UserModel.fromJson(data['data']);
      }

      log('Session Declined', name: 'API SESSION');

      if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        return data['message'].toString();
      }

      //
    } catch (e) {
      Get.close(1);
      log(e.toString(), name: 'API SESSION CLIENT ERROR');
    }
    return 'Cannot connect to server';
  }
}
