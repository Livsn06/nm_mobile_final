import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

late CameraDescription cameraDescription;
RxBool isOpenCamera = false.obs;
late PageController pageController;
