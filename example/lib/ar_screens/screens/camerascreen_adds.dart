import 'dart:developer';

import 'package:arcore_flutter_plugin_example/controllers/Home_Control/dashboard_controller.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_plant.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:get/get.dart';

import '../../constants/global_adds.dart';
import '../../controllers/Data_Control/ct_plant.dart';
import '../../controllers/Home_Control/clientrqst_controller.dart';
import '../../controllers/Home_Control/home_controller.dart';
import 'api_sample_adds.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;
  Function isScaned;
  CameraScreen({required this.camera, required this.isScaned});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  var ctPlant = Get.put(CtPlant());
  var ctDashboard = Get.put(HomeController());
  RxBool _isCapturing = false.obs;

  //
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<File?> captureBestImage() async {
    List<XFile> images = [];

    try {
      for (int i = 0; i < 10; i++) {
        await _controller.setFlashMode(FlashMode.off);
        await _controller.setFocusMode(FocusMode.auto);
        log('Capturing image... (${i + 1}/10)');
        final image = await _controller.takePicture();
        images.add(image);
      }

      // Analyze image qualities (e.g., resolution or file size)
      XFile bestImage = images.first;
      int maxSize = await images.first.length();
      for (XFile image in images) {
        int fileSize = await image.length();
        if (fileSize > maxSize) {
          bestImage = image;
          maxSize = fileSize;
        }
      }

      return File(bestImage.path);
    } catch (e) {
      print("Error capturing images: $e");
      return null;
    }
  }

//

  resultScan() async {
    _isCapturing.value = true;

    // Capture the best image
    File? bestImage = await captureBestImage();

    if (bestImage != null) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content:
      //         Text("Image captured: ${bestImage.path}"),
      //   ),
      // );

      var data = await IdentifyPlant().identifyPlant(bestImage);

      if (data == null) {
        Get.defaultDialog(
          title: "Can't Identify Plant",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Retry Scanning Plant",
              ),
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    _isCapturing.value = false;
                    Get.back();
                  });
                },
                child: Text("Retry"),
              ),
            ],
          ),
        );
        return;
      }

      var bestMatch = data['bestMatch'];

      var databaseApiResult = ctPlant.getPlantByScientificName(bestMatch);
      var requestController = Get.put(ClientRequestController());
      if (databaseApiResult == null) {
        Get.defaultDialog(
            title: "Plan't Identified",
            contentPadding: EdgeInsets.all(20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.file(bestImage,
                    width: 220, height: 220, fit: BoxFit.cover),
                SizedBox(height: 20),
                Text("Scientific Name: ${bestMatch}",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    )),
                SizedBox(height: 5),
                Text(
                  "- New Plant Identified -",
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Do you want to add it as your request?",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          _isCapturing.value = false;
                          Get.back();
                        });
                      },
                      child: Text("Cancel"),
                    ),
                    SizedBox(width: 20),
                    MaterialButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          _isCapturing.value = false;
                          Get.back();
                          ctDashboard.updateIndex(3);
                          pageController.jumpToPage(3);
                          requestController.selectedFiles.value.add(bestImage);
                          requestController.isOnPlantIdentification.value =
                              true;
                          requestController.titleController.text = bestMatch;
                          requestController.isListVisible.value = false;
                        });
                      },
                      child: Text("Request"),
                    ),
                  ],
                ),
              ],
            ));
        return;
      } else {
        PlantModel plant = databaseApiResult;
        widget.isScaned(plant);
      }
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              Positioned.fill(
                child: CameraPreview(_controller),
              ),
              Positioned(
                bottom: 35,
                left: 20,
                right: 20,
                child: InkWell(
                  onTap: _isCapturing.value
                      ? () {
                          _isCapturing.value = false;
                          setState(() {});
                        }
                      : () {
                          resultScan();
                        },
                  child: Obx(() {
                    return CircleAvatar(
                      radius: size.width / 9,
                      backgroundColor:
                          _isCapturing.value ? Colors.red : Color(0xFF008263),
                      child: Text(_isCapturing.value ? "Stop" : "Scan",
                          style: TextStyle(
                              fontSize: size.width / 20, color: Colors.white)),
                    );
                  }),
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
