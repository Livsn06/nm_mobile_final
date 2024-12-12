import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class IdentifyPlant {
  Future<Map<String, dynamic>?> identifyPlant(File imageFile) async {
    // API configuration
    const String apiKey = "2b10XPlqYiNQCwnUjgr6VlrO"; // Add your API key here
    const String project =
        "all"; // Change to your project ("weurope", "canada", etc.)
    final String url =
        "https://my-api.plantnet.org/v2/identify/$project?api-key=$apiKey";

    try {
      // Prepare the multipart request
      var request = http.MultipartRequest("POST", Uri.parse(url));

      // Add the image files
      request.files.add(
        await http.MultipartFile.fromPath("images", imageFile.path,
            filename: imageFile.path.split('/').last),
      );

      // Send the request
      var response = await request.send();

      // Process the response
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResult = jsonDecode(responseBody);
        log("PlantNet Response: $jsonResult");
        return jsonResult;
      } else {
        var errorBody = await response.stream.bytesToString();
        log("Error ${response.statusCode}: $errorBody");
        return null;
      }
    } catch (e) {
      log("Exception occurred: $e");
      return null;
    }
    return null;
  }
}
