import 'dart:ui';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class HelloWorld extends StatefulWidget {
  @override
  _HelloWorldState createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> {
  ArCoreController? arCoreController;

  @override
  Widget build(BuildContext context) {
    return ArCoreView(
      onArCoreViewCreated: _onArCoreViewCreated,
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    _addFlatObjectInWidth();
    // _addSphere();
    _addRectangle();
    // // _addCylindre();
    // _addCube();
  }

  // Future _addSphere() async {
  //   final ByteData textureBytes = await _createTextImage('Hello World');

  //   final material = ArCoreMaterial(
  //       color: Color.fromARGB(120, 66, 134, 244),
  //       textureBytes: textureBytes.buffer.asUint8List());
  //   final sphere = ArCoreSphere(
  //     materials: [material],
  //     radius: 0.1,
  //   );
  //   final node = ArCoreNode(
  //     shape: sphere,
  //     position: vector.Vector3(0, 0, -1.5),
  //   );
  //   arCoreController?.addArCoreNode(node);
  // }

  // void _addSphere() async {
  //   // Load the texture from assets
  //   final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

  //   // Create the material with the texture
  //   final material = ArCoreMaterial(
  //     textureBytes: textureBytes.buffer.asUint8List(),
  //     color: Color.fromARGB(
  //         120, 66, 134, 244), // Optional: add a base color if needed
  //   );

  //   // Define the sphere shape
  //   final sphere = ArCoreSphere(
  //     materials: [material],
  //     radius: 1.0, // Adjust the radius as needed
  //   );

  //   // Create the ARCoreNode with the sphere
  //   final node = ArCoreNode(
  //     shape: sphere,
  //     position: vector.Vector3(-0.5, 0.5, -3.5), // Set the position in AR space
  //   );

  //   // Add the node to the ARCore controller
  //   arCoreController?.addArCoreNode(node);
  // }

  // void _addCube() async {
  //   final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

  //   final material = ArCoreMaterial(
  //       color: Color.fromARGB(120, 66, 134, 244),
  //       textureBytes: textureBytes.buffer.asUint8List());
  //   final cube = ArCoreCube(
  //     materials: [material],
  //     size: vector.Vector3(0.5, 0.5, 0.5),
  //   );
  //   final node = ArCoreNode(
  //     shape: cube,
  //     position: vector.Vector3(-0.5, 0.5, -3.5),
  //   );
  //   arCoreController?.addArCoreNode(node);
  // }

  void _addRectangle() async {
    // Load the texture from assets
    final ByteData textureBytes = await _createTextImage(
        'Aloe Vera\n\n\tAloe vera is a herb with succulent leaves that are arranged in a rosette. The leaves are grey to green and sometimes have white spots on their surfaces. They have sharp, pinkish spines along their edges and are the source of the colorless gel found in many commercial and medicinal products.',
        200,
        300);

    // Create the material with the texture
    final material = ArCoreMaterial(
      textureBytes: textureBytes.buffer.asUint8List(),
      color: Color.fromRGBO(0, 220, 176, 1), // Optional color overlay
    );

    // Define the rectangle with different dimensions
    final rectangle = ArCoreCube(
      materials: [material],
      size: vector.Vector3(
        7,
        10,
        0.01,
      ), // Width, height, depth (thin depth for a flat look)
    );

    // Create the node for the rectangle
    final node = ArCoreNode(
      shape: rectangle,
      position: vector.Vector3(-0.8, -0.5, -13), // Position in AR space
    );

    // Add the node to the ARCore controller
    arCoreController?.addArCoreNode(node);
  }

  void _addFlatObjectInWidth() async {
    // Load the texture from assets
    final ByteData textureBytes = await rootBundle.load('assets/alobera.jpg');

    // Create the material with the texture
    final material = ArCoreMaterial(
      textureBytes: textureBytes.buffer.asUint8List(),
      color: Color.fromARGB(120, 66, 134, 244), // Optional base color
    );

    // Define the shape using an ArCoreCube with a small width
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(
          0.9, 0.9, 0.01), // Flat in width (x-axis), normal in height and depth
    );

    // Create the ARCoreNode with the cube
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(-0.5, 1.0, -3.5), // Set the position in AR space
    );

    // Add the node to the ARCore controller
    arCoreController?.addArCoreNode(node);
  }

  // void _addCylindre() {
  //   final material = ArCoreMaterial(
  //     color: Colors.red,
  //     reflectance: 1.0,
  //   );
  //   final cylindre = ArCoreCylinder(
  //     materials: [material],
  //     radius: 0.5,
  //     height: 0.3,
  //   );
  //   final node = ArCoreNode(
  //     shape: cylindre,
  //     position: vector.Vector3(0.0, -0.5, -2.0),
  //   );
  //   arCoreController?.addArCoreNode(node);
  // }

  // Future<ByteData> _createTextImage(String text) async {
  //   final recorder = PictureRecorder();
  //   final canvas = Canvas(recorder);
  //   final paint = Paint()..color = Colors.white;
  //   final textPainter = TextPainter(
  //     text: TextSpan(
  //       text: text,
  //       style: TextStyle(
  //         color: Colors.black,
  //         fontSize: 24,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     textDirection: TextDirection.ltr,
  //   );

  //   textPainter.layout();
  //   final size = textPainter.size;
  //   canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  //   textPainter.paint(canvas, Offset.zero);

  //   final picture = recorder.endRecording();
  //   final img = await picture.toImage(size.width.toInt(), size.height.toInt());
  //   final byteData = await img.toByteData(format: ImageByteFormat.png);

  //   return byteData!;
  // }

  Future<ByteData> _createTextImage(
      String text, double width, double height) async {
    final recorder = PictureRecorder();
    final canvas =
        Canvas(recorder, Rect.fromPoints(Offset(0, 0), Offset(width, height)));
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 202, 209); // Background color
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 13,
      fontWeight: FontWeight.bold,
    );

    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: width);
    final offset = Offset(
        (width - textPainter.width) / 2, (height - textPainter.height) / 2);
    textPainter.paint(canvas, offset);

    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());
    final byteData = await img.toByteData(format: ImageByteFormat.png);

    return byteData!;
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    
    super.dispose();
  }
}
