import 'dart:math';

import 'package:arcore_flutter_plugin_example/constants/global_adds.dart';
import 'package:arcore_flutter_plugin_example/controllers/Data_Control/ct_plant.dart';
import 'package:arcore_flutter_plugin_example/controllers/Data_Control/ct_remedy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arcore_flutter_plugin_example/controllers/Home_Control/home_controller.dart';
import 'package:arcore_flutter_plugin_example/utils/responsive.dart';
import '../../components/cust_bottomnav.dart';
import '../../controllers/Home_Control/bookmark_controller.dart';
import 'bookmark_screen.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'request_screen.dart';
import 'scanner_screen.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen>
    with WidgetsBindingObserver {
  //
  CtPlant ctPlant = Get.put(CtPlant());
  CtRemedy ctRemedy = Get.put(CtRemedy());

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    final int? initialPage = Get.arguments as int?;
    if (initialPage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pageController.jumpToPage(initialPage);
        Get.find<HomeController>().updateIndex(initialPage);
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      int? index = Get.arguments as int?;
      if (index != null) {
        Get.find<HomeController>().updateIndex(index);
        pageController.jumpToPage(index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BookmarkController());
    return GetBuilder<HomeController>(
      init: Get.put(HomeController(), permanent: false),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                if (index == 2) {
                  isOpenCamera.value = true;
                } else {
                  isOpenCamera.value = false;
                }
                if (controller.selectedIndex.value != index) {
                  controller.updateIndex(index);
                }
              },
              children: [
                DashboardScreen(),
                BookmarkScreen(),
                ScannerScreen(),
                RequestScreen(),
                ProfileScreen(),
              ],
            ),
            Obx(() {
              return Visibility(
                visible: !isOpenCamera.value,
                child: Positioned(
                  bottom: setResponsiveSize(context, baseSize: 0),
                  left: setResponsiveSize(context, baseSize: 0),
                  right: setResponsiveSize(context, baseSize: 0),
                  child: Obx(
                    () => ButtomNav(
                      selectedIndex: controller.selectedIndex.value,
                      onTap: (index) {
                        if (pageController.page != index.toDouble()) {
                          controller.updateIndex(index);
                          pageController.jumpToPage(index);
                        }
                      },
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
