import 'package:arcore_flutter_plugin_example/ar_screens/screens/camerascreen_adds.dart';
import 'package:arcore_flutter_plugin_example/ar_screens/screens/hello_world_adds.dart';
import 'package:arcore_flutter_plugin_example/constants/global_adds.dart';
import 'package:arcore_flutter_plugin_example/controllers/Data_Control/ct_plant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arcore_flutter_plugin_example/utils/_initApp.dart';

import '../../utils/responsive.dart';
import 'control_screen.dart';

class ScannerScreen extends StatefulWidget with Application {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> with Application {
  var ctPlant = Get.put(CtPlant());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.light,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: color.primary),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.primary,
                  color.primarylow,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: InkWell(
            onTap: () => Get.offAll(() => const ControlScreen(), arguments: 0),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: color.white,
              size: setResponsiveSize(context, baseSize: 18),
            ),
          ),
          title: Text(
            'SCANNER',
            style: style.displaySmall(
              context,
              color: color.white,
              fontsize: setResponsiveSize(context, baseSize: 15),
              fontweight: FontWeight.w500,
              fontspace: 2,
              fontstyle: FontStyle.normal,
            ),
          ),
        ),
      ),
      body: ARScreen(),
    );
  }
}
