import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/data_model/md_image.dart';

class ApiImage {
  static String base = dotenv.env['API_BASE']!;
  static Future<ImageModel?> getImage(String image) async {
    String url = '$base/api/v1/images/image';
    // String? token = await SessionAccess.instance.getSessionToken();

    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      // 'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: {'path': image},
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Plant Image fetched successfully', name: 'API GET IMAGES');
        final result = jsonDecode(response.body);
        return ImageModel.fromJson(result['data']);
      }

      log(response.statusCode.toString(), name: 'API GET IMAGES ERROR');

      return null;
      //
    } catch (e) {
      log(e.toString(), name: 'API IMAGES CLIENT ERROR');
      return null;
    }
  }
}
