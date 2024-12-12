import 'package:arcore_flutter_plugin_example/api/api_session.dart';
import 'package:arcore_flutter_plugin_example/constants/_savedUser.dart';
import 'package:arcore_flutter_plugin_example/utils/_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arcore_flutter_plugin_example/routes/screen_routes.dart';

import '../../models/data_model/md_user.dart';
import '../../utils/_initApp.dart';
import '../Data_Control/ct_plant.dart';
import '../Data_Control/ct_remedy.dart';

class SplashController extends GetxController {
  CtPlant ctPlant = Get.put(CtPlant());
  CtRemedy ctRemedy = Get.put(CtRemedy());

  //
  @override
  void onReady() {
    sessionCheck();
    super.onReady();
  }

  Future<bool> isFirstTimeUser() async {
    var session = await SessionAccess.instance
        .getSessionToken(sessionName: SessionAccess.names.SESSION_FIRST_RUN);
    return session == null;
  }

  Future<bool> isUserSignedIn() async {
    var session = await SessionAccess.instance.getSessionToken(
      sessionName: SessionAccess.names.SESSION_LOGIN,
    );
    print("Session Active: $session");
    if (session == null) {
      return false;
    }
    var response = await SessionApi.auth.session(token: session);
    if (response is String) {
      SessionAccess.instance.deleteSessionToken(
        sessionName: SessionAccess.names.SESSION_LOGIN,
      );
      SessionAccess.instance.deleteUserData();
      return false;
    } else {
      CURRENT_USER.value = response as UserModel;
    }

    return CURRENT_USER.value.email != null;
  }

  Future showNextScreen() async {
    await Future.delayed(4.seconds);

    if (await isFirstTimeUser()) {
      await Get.toNamed(ScreenRouter.getOnboardingRoute);
      return;
    } else {
      await Get.toNamed(ScreenRouter.getGetstartedRoute);
    }
  }

  void sessionCheck() async {
    if (await isUserSignedIn()) {
      await Get.toNamed(ScreenRouter.getControlscreenRoute);
      Get.snackbar(
        'Successfully Login',
        'Welcome back, ${CURRENT_USER.value.name}!',
        icon:
            Icon(Icons.check_circle_outline, color: Application().color.white),
        colorText: Application().color.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Application().color.valid,
      );
      ctPlant.loadData();
      ctRemedy.loadData();
      return;
    }

    await showNextScreen();
  }
}
