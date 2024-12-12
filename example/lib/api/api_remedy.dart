import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/data_model/md_remedy.dart';
import '../utils/_session.dart';

class RemedyApi {
  //
  static String base = dotenv.env['API_BASE']!;
  static Future<List<RemedyModel>?> fetchAllRemedies() async {
    String url = '$base/api/v1/remedies';
    String? token = await SessionAccess.instance.getSessionToken(
      sessionName: SessionAccess.names.SESSION_LOGIN,
    );

    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);

        // log(result['data'].toString(), name: 'API REMEDIES');
        log('Remedies fetched successfully', name: 'API Remedies');
        return RemedyModel.fromJsonList(result['data']);
      }

      log(response.statusCode.toString(), name: 'API Remedies ERROR');
      final result = jsonDecode(response.body);
      return null;

      //
    } catch (e) {
      log(e.toString(), name: 'API Remedies CLIENT ERROR');
      return null;
    }
  }

  ///
  ///
  // static Future<ResponseModel> getRemedy(int id) async {
  //   String base = API_BASE.value;
  //   String url = '$base/api/v1/remedies/$id';
  //   String? token = await SessionAccess.instance.getSessionToken();

  //   var headers = {
  //     'Accept': 'application/json',
  //     'ngrok-skip-browser-warning': 'true',
  //     'Authorization': 'Bearer $token'
  //   };

  //   try {
  //     var response = await http.get(Uri.parse(url), headers: headers);

  //     //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       log('Remedy fetched successfully', name: 'API GET REMEDY');
  //       final result = jsonDecode(response.body);
  //       return ResponseModel.dataFromJson(result, success: true);
  //     }

  //     log(response.statusCode.toString(), name: 'API GET REMEDY ERROR');
  //     final result = jsonDecode(response.body);
  //     return ResponseModel.errorFromJson(
  //       result,
  //       success: false,
  //     );

  //     //
  //   } catch (e) {
  //     log(e.toString(), name: 'API ERROR GET REMEDY');
  //     return ResponseModel.clientErrorFromJson(
  //       message: 'Cannot connect to server',
  //       success: false,
  //     );
  //   }
  // }
}
