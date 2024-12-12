import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/data_model/md_plant.dart';
import '../utils/_session.dart';

// "message": "Plant fetch successfully",
//     "data": [
//         {
//             "id": 5,
//             "name": "Aloe vera",
//             "scientific_name": "Aloe barbadensis miller",
//             "local_name": "[\"Sabila\"]",
//             "description": "Aloe vera, often called the \"plant of immortality,\" is a succulent plant known for its thick, fleshy leaves filled with a gel-like substance. Native to arid regions, it thrives in warm climates and has been used for centuries in traditional medicine, skincare, and wellness practices.",
//             "status": "inactive",
//             "image_path": "[\"plant_image\\/1733209455_Aloe vera1.jpg\",\"plant_image\\/1733209456_Aloe vera2.jpg\",\"plant_image\\/1733209456_Aloe vera3.jpg\",\"plant_image\\/1733209456_Aloe vera4.jpg\"]",
//             "uploader_id": null,
//             "created_at": "2024-12-03T07:04:16.000000Z",
//             "updated_at": "2024-12-03T07:04:16.000000Z"
//         }
//     ]
class PlantApi {
  //
  static String base = dotenv.env['API_BASE']!;
  static Future<List<PlantModel>?> fetchAllPlants() async {
    String url = '$base/api/v1/plants';
    String? token = await SessionAccess.instance.getSessionToken(
      sessionName: SessionAccess.names.SESSION_LOGIN,
    );

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      //
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        log('Plants fetched successfully', name: 'API PLANT');
        // log(result['data'].toString(), name: 'API PLANT');
        return PlantModel.listFromJson(result['data']);
      }

      log(response.statusCode.toString(), name: 'API PLANT ERROR');
      final result = jsonDecode(response.body);
      return null;

      //
    } catch (e) {
      log(e.toString(), name: 'API PLANT CLIENT ERROR');
    }
    return null;
  }
}
