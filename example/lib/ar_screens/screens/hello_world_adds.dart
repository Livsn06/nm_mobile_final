import 'dart:developer';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:arcore_flutter_plugin_example/screen/Info/plantInfo_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import '../../models/data_model/md_plant.dart';
import 'camerascreen_adds.dart';
import '../../constants/global_adds.dart';

class ARScreen extends StatefulWidget {
  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  ArCoreController? arCoreController;
  PlantModel? plant;
  var node1;
  var node2;
  bool isScaned = false;
  bool istoPlantInfo = false;
  @override
  void initState() {
    seeAvailability();

    super.initState();
  }

  void seeAvailability() async {
    print('ARCORE IS AVAILABLE?');
    print(await ArCoreController.checkArCoreAvailability());
    print('\nAR SERVICES INSTALLED?');
    print(await ArCoreController.checkIsArCoreInstalled());
    isOpenCamera.value = true;
  }

  void toggleScan(PlantModel plantScaned) {
    setState(() {
      plant = plantScaned;
      isScaned = !isScaned;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        isScaned
            ? Stack(
                children: [
                  ArCoreView(onArCoreViewCreated: _onArCoreViewCreated),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      color: Color(0xFF4CAF50),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlantInfoScreen(plant: plant!),
                          ),
                        );
                      },
                      child: Text('Find Remedy'),
                    ),
                  )
                ],
              )
            : CameraScreen(
                camera: cameraDescription,
                isScaned: toggleScan,
              ),
      ],
    );
  }

  void _onArCoreViewCreated(ArCoreController? controller) async {
    arCoreController = controller;
    // Future.delayed(Duration(seconds: 10), () {

    if (arCoreController != null) {
      _addCube();
      _addRectangle();
    }

    // });
    // _addSphere();
  }

  // Future _addSphere() async {
  //   final ByteData textureBytes = await loadNetworkImage(
  //       'https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=eYADMQ9dXTz1mggdfn_exN2gY61aH4fJz1lfMomv6o4=');

  //   final material = ArCoreMaterial(
  //       color: Color.fromARGB(120, 66, 134, 244),
  //       textureBytes: textureBytes.buffer.asUint8List());
  //   final sphere = ArCoreSphere(
  //     materials: [material],
  //     radius: 0.1,
  //   );
  //   final node = ArCoreNode(
  //     shape: sphere,
  //     position: vector.Vector3(0, 0, -2.5),
  //   );
  //   arCoreController?.addArCoreNode(node);
  // }

  Future _addCube() async {
    try {
      final ByteData textureBytes =
          await loadNetworkImage('${plant!.images![0]}');
      final material = ArCoreMaterial(
          color: Color.fromARGB(120, 66, 134, 244),
          textureBytes: textureBytes.buffer.asUint8List());
      final cube = ArCoreCube(
        materials: [material],
        size: vector.Vector3(0.7, 0.7, 0.001),
      );
      node1 = ArCoreNode(
        shape: cube,
        position: vector.Vector3(0, 0.9, -2.0),
      );
      arCoreController?.addArCoreNode(node1);
    } catch (e) {}
  }

  Future _addRectangle() async {
    try {
      final ByteData textureBytes = await createTextTexture(
        title: "${plant!.name}",
        scientific_name: "${plant!.scientific_name}",
        description: "${plant!.description!}",
        width: 512,
        height: 512,
      );

      // Use textureBytes as needed (e.g., ARCore material)

      final material = ArCoreMaterial(
        color: Color.fromARGB(120, 66, 134, 244),
        textureBytes: textureBytes.buffer.asUint8List(),
      );
      final cube = ArCoreCube(
        materials: [material],
        size: vector.Vector3(1.5, 2, 0.001),
      );
      node2 = ArCoreNode(
        shape: cube,
        position: vector.Vector3(0, -0.2, -2.5),
      );
      arCoreController?.addArCoreNode(node2);
    } catch (e) {}
  }

  Future<ByteData> loadNetworkImage(String imageUrl) async {
    try {
      // Fetch the image from the network
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Convert the response body to Uint8List
        Uint8List bytes = response.bodyBytes;

        // Convert Uint8List to ByteData
        return ByteData.view(bytes.buffer);
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      log('Error loading network image: $e');
      throw Exception('Error loading network image: $e');
    }
  }

  Future<ByteData> createTextTexture(
      {required String title,
      required String scientific_name,
      required String description,
      required double width,
      required double height}) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = const Color(0xD4FFFFFF); // White background

    // Draw a background
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

    // Draw the text
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: "- $title -\n",
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ), // Black text
          children: <TextSpan>[
            TextSpan(
              text: "Scientific name: $scientific_name\n\n",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color(0xFF000000),
                fontSize: 18.0,
              ), // Green text
            ),
            TextSpan(
              text: description,
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 20.0,
              ), // Green text
            ),
          ]),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: width);
    textPainter.paint(canvas, Offset(10, height / 2 - textPainter.height / 2));

    // Convert canvas to image
    final picture = recorder.endRecording();
    final image = await picture.toImage(width.toInt(), height.toInt());

    // Convert image to byte data
    return await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
  }

  ///
  ///

  @override
  void dispose() {
    // arCoreController?.removeNode(nodeName: node1.name);
    // arCoreController?.removeNode(nodeName: node2.name);
    arCoreController?.dispose();
    super.dispose();
  }
}
