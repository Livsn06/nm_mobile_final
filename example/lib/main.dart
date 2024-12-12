import 'package:arcore_flutter_plugin_example/constants/global_adds.dart';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'
    show ArCoreController;

import 'dart:developer';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:arcore_flutter_plugin_example/helper/_init_dependencies.dart';
import 'package:arcore_flutter_plugin_example/routes/screen_routes.dart';
import 'package:path_provider/path_provider.dart';
import 'SCREEN/SPLASH/splash_screen.dart';
import 'package:camera/camera.dart';
import 'firebase_options.dart';
import 'models/client_data.dart';
import 'models/plant_info.dart';
import 'models/rating_data.dart';
import 'models/remedy_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );

  // Initialize environment variables
  await dotenv.load(fileName: ".env");
  await initializeCamera();
  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Register Adapters
  Hive.registerAdapter(PlantDataAdapter());
  Hive.registerAdapter(RemedyInfoAdapter());
  Hive.registerAdapter(RatingDataAdapter());
  Hive.registerAdapter(ClientDataAdapter());

  // Open Boxes
  await Hive.openBox('bookmarks');
  await Hive.openBox('clientRequests');
  await Hive.openBox('userBox');
  await Hive.openBox('bookmarkedPlants');
  await Hive.openBox('bookmarkedRemedies');
  await Hive.openBox('bookmarkHistory');
  runApp(MainApp());
}

Future initializeCamera() async {
  final cameras = await availableCameras();
  cameraDescription = cameras.first;
}

class MainApp extends StatelessWidget {
  MainApp({super.key}) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    log(name: 'API BASE', dotenv.env['API_BASE']!.toString());

    return GetMaterialApp(
      initialBinding: InitDep(),
      initialRoute: ScreenRouter.getSplashscreenRoute,
      getPages: ScreenRouter.routes,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
