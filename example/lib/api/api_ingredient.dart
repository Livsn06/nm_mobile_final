import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/data_model/md_ingredient.dart';

class IngredientApi {
  static String base = dotenv.env['API_BASE']!;

  static Future<List<IngredientModel>?> fetchAllIngredients() async {
    String url = '$base/api/v1/ingredients';
    // String? token = await SessionAccess.instance.getSessionToken();
    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      // 'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Ingrdients fetch successful', name: 'API Ingrdients');
        return IngredientModel.listFromJson(data['data']);
      }

      if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        return null;
      }

      if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        return null;
      }
    } catch (e) {
      Get.close(1);
      log(e.toString(), name: 'API Ingrdients CLIENT ERROR');
    }
    return null;
  }
}
