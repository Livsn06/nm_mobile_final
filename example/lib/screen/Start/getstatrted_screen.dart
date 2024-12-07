import 'dart:ui'; // Import this to use ImageFilter
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:arcore_flutter_plugin_example/routes/screen_routes.dart';
import 'package:arcore_flutter_plugin_example/Utils/_initApp.dart';
import 'package:arcore_flutter_plugin_example/Utils/responsive.dart';

class GetstartedScreen extends StatelessWidget with Application {
  GetstartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(color: color.white),
          ),
          Align(
            alignment: Alignment(0, setResponsiveSize(context, baseSize: 0.15)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    setResponsiveSize(context, baseSize: size.width * 0.05),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(setResponsiveSize(context, baseSize: size.height * 0.07)),
                  Text(
                    'NATUREMEDIX',
                    style: style.displayLarge(context,
                        color: color.primarylow,
                        fontspace: 3,
                        fontsize: size.width * 0.08),
                  ),
                  Gap(setResponsiveSize(context,
                      baseSize: size.height * 0.016)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: setResponsiveSize(context,
                          baseSize: size.width * 0.08),
                    ),
                    child: Text(
                      '“Explore herbal plants and discover natural remedies to enhance your health and overall well-being.”',
                      textAlign: TextAlign.center,
                      style: style.TitleMedium(
                        context,
                        color: color.primarylow,
                        fontsize: size.width * 0.045,
                      ),
                    ),
                  ),
                  Gap(
                    setResponsiveSize(
                      context,
                      baseSize: size.height / 900,
                    ),
                  ),
                  Image.asset(
                    image.BG5,
                    fit: BoxFit.cover,
                    scale: setResponsiveSize(
                      context,
                      baseSize: size.width / 230,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: setResponsiveSize(context,
                          baseSize: size.width * 0.04),
                      vertical: setResponsiveSize(context,
                          baseSize: size.height * 0.05),
                    ),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              elevation: WidgetStatePropertyAll(
                                  setResponsiveSize(context, baseSize: 2)),
                              shape: WidgetStatePropertyAll<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                side: BorderSide(
                                    color: color.primarylow, width: 1),
                                borderRadius: BorderRadius.circular(
                                    setResponsiveSize(context, baseSize: 5)),
                              )),
                              backgroundColor: const WidgetStatePropertyAll(
                                  Color(0xFFF5F5F5))),
                          onPressed: () =>
                              Get.toNamed(ScreenRouter.getRegisterRoute),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    setResponsiveSize(context, baseSize: 13)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'REGISTER',
                                  textAlign: TextAlign.center,
                                  style: style.buttonText(context,
                                      color: color.primarylow,
                                      fontspace: 1.5,
                                      fontsize: setResponsiveSize(context,
                                          baseSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(setResponsiveSize(context,
                            baseSize: size.height * 0.02)),
                        ElevatedButton(
                          style: ButtonStyle(
                              elevation: WidgetStatePropertyAll(
                                  setResponsiveSize(context, baseSize: 3)),
                              shape: WidgetStatePropertyAll<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          setResponsiveSize(context,
                                              baseSize: 5)))),
                              backgroundColor:
                                  WidgetStatePropertyAll(color.primarylow)),
                          onPressed: () =>
                              Get.toNamed(ScreenRouter.getLoginRoute),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    setResponsiveSize(context, baseSize: 13)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'LOGIN',
                                  textAlign: TextAlign.center,
                                  style: style.buttonText(context,
                                      color: color.white,
                                      fontspace: 1.5,
                                      fontsize: setResponsiveSize(context,
                                          baseSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
