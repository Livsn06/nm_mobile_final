import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:arcore_flutter_plugin_example/models/upload_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/data_model/md_request_plant.dart';
import '../utils/_session.dart';

class RequestApi {
  static String base = dotenv.env['API_BASE']!;

  //
  static Future<List<RequestPlantModel>?> fetchAllRequests() async {
    String url = '$base//api/v1/plantsAdditions';

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

      if (response.statusCode == 200) {
        log('Request fetched successfully', name: 'API PLANT REQUEST');
        final result = jsonDecode(response.body);
        return RequestPlantModel.listFromJson(result['data']);
      }
      return null;
    } catch (e) {
      log(e.toString(), name: 'API ERROR');
      return null;
    }
  }

  //

  static Future<bool> addRequest(
      RequestPlantModel addition, List<File> images) async {
    String url = '$base/api/v1/plantsAdditions';
    String? token = await SessionAccess.instance.getSessionToken(
      sessionName: SessionAccess.names.SESSION_LOGIN,
    );

    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var multipart = await http.MultipartRequest("POST", Uri.parse(url));

      multipart.headers.addAll(headers);

      multipart.fields['scientific_name'] = addition.scientific_name!;
      multipart.fields['description'] = addition.description!;

      for (var image in images) {
        multipart.files.add(await http.MultipartFile.fromPath(
          'images[]',
          image.path,
          filename: image.path.split('/').last,
        ));
      }

      var response = await multipart.send();

      if (response.statusCode == 200) {
        log('Request added successfully', name: 'API PLANT REQUEST');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString(), name: 'API ERROR');
      return false;
    }
  }
}
