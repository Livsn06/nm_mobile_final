

import 'package:get/get.dart';
import 'package:arcore_flutter_plugin_example/routes/screen_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    showNextScreen();
    super.onReady();
  }

  Future showNextScreen() async {
    await Future.delayed(4.seconds);
    await Get.toNamed(ScreenRouter.getOnboardingRoute);
  }
}
