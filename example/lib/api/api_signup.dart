import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/data_model/md_user.dart';

class SignupApi {
  String base = dotenv.env['API_BASE']!;
  static final auth = SignupApi();

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
}
