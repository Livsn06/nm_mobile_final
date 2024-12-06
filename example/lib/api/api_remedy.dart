import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import '../models/data_model/md_remedy.dart';
import '../models/data_model/md_remedy_plant.dart';
import '../models/data_model/md_remedy_treatment.dart';
import '../models/upload_data.dart';

class ApiRemedy {
  //
  static String base = dotenv.env['API_BASE']!;
  static Future<List<RemedyModel>?> fetchAllRemedies() async {
    String url = '$base/api/v1/remedies';
    // String? token = await SessionAccess.instance.getSessionToken();

    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      // 'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);

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

  //=====================================================================================================

  static Future<RemedyModel?> uploadRemedy(
      {required RemedyModel remedy,
      required List<FormImageModel> images}) async {
    String url = '$base/api/v1/remedies';
    // String? token = await SessionAccess.instance.getSessionToken();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        // 'Authorization': 'Bearer $token'
      });

      request.fields.addAll(remedy.toCreateRemedyJson());

      for (var image in images) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'images[]',
            image.bytes!,
            filename: image.name,
          ),
        );
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('plant uploaded successfully', name: 'API PLANT UPLOADED');
        final result = jsonDecode(responseData);
        return RemedyModel.fromJson(result['data']);
      }
      log(response.statusCode.toString(), name: 'API ERROR PLANT UPLOAD');
      final result = jsonDecode(responseData);
      return null;
      //
    } catch (e) {
      log(': CLIENT ERROR', name: 'API PLANT UPLOAD');
      return null;
    }
  }

  ////  ============================================================================================

  static Future<RemedyTreatmentModel?> uploadRemedyTreatment(
      {required RemedyTreatmentModel ailment}) async {
    String url = '$base/api/v1/remedies/treatments';
    // String? token = await SessionAccess.instance.getSessionToken();

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          // 'Authorization': 'Bearer $token'
        },
        body: ailment.toJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Usage uploaded successfully', name: 'API REMEDY USAGE UPLOAD');
        final result = jsonDecode(response.body);
        return RemedyTreatmentModel.fromJson(result['data']);
      }

      log('${response.statusCode}', name: 'API ERROR REMEDY USAGE UPLOAD');
      final result = jsonDecode(response.body);
      return null;
    } catch (e) {
      log(': CLIENT ERROR', name: 'API REMEDY USAGE UPLOAD', error: e);
      return null;
    }
  }
}
