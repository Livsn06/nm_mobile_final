import 'package:arcore_flutter_plugin_example/controllers/Data_Control/ct_remedy.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_plant.dart';
import 'package:arcore_flutter_plugin_example/screen/Info/remedy_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../controllers/Home_Control/bookmark_controller.dart';
import '../../controllers/PlantInfo_Control/plantInfos_controller.dart';
import '../../models/plant_info.dart';
import '../../models/remedy_info.dart';
import '../../utils/NeoBox.dart';
import '../../utils/_initApp.dart';
import '../../utils/responsive.dart';

class PlantInfoScreen extends StatefulWidget {
  final PlantModel plant;
  const PlantInfoScreen({super.key, required this.plant});

  @override
  State<PlantInfoScreen> createState() => _PlantInfoScreenState();
}

class _PlantInfoScreenState extends State<PlantInfoScreen> with Application {
  final PageController _pageController = PageController(initialPage: 0);
  final PlantInfoController plantInfoController =
      Get.put(PlantInfoController());

  final CtRemedy ctRemedy = Get.put(CtRemedy());

  @override
  void initState() {
    super.initState();
    // plantInfoController.fetchReactionState(widget.plant.plantName);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarkController>(
      init: Get.put(BookmarkController()),
      builder: (controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBar(
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
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: color.white,
                  size: setResponsiveSize(context, baseSize: 18),
                ),
              ),
              title: Text(
                'HERBAL PLANT INFO',
                style: style.InterSmallText(
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
          backgroundColor: color.darklight,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          setResponsiveSize(context, baseSize: 20)),
                      child: SizedBox(
                        height: setResponsiveSize(context, baseSize: 250),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget.plant.images!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(
                                  setResponsiveSize(context, baseSize: 8)),
                              child: NeoBox(
                                borderRadius: BorderRadius.circular(
                                    setResponsiveSize(context, baseSize: 5)),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      setResponsiveSize(context, baseSize: 12)),
                                  child: Image.network(
                                    widget.plant.images![index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: color.white,
                  padding: EdgeInsets.only(
                      right: setResponsiveSize(context, baseSize: 20),
                      left: setResponsiveSize(context, baseSize: 20),
                      top: setResponsiveSize(context, baseSize: 30),
                      bottom: setResponsiveSize(context, baseSize: 40)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.plant.name!,
                            style: style.InterSmallText(context,
                                color: color.primarylow,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 20),
                                fontweight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Obx(
                            () => InkWell(
                              child: Material(
                                borderRadius: BorderRadius.circular(5),
                                elevation: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      setResponsiveSize(context, baseSize: 10)),
                                  child: Icon(
                                    // Change the icon based on the toggle status
                                    plantInfoController.isReacted.value
                                        ? Icons.favorite // Active icon
                                        : Icons
                                            .favorite_outline, // Inactive icon
                                    color: color.primary,
                                  ),
                                ),
                              ),
                              onTap: () {
                                // plantInfoController
                                //     .toggleReactButton(widget.plant.plantName);
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Scientific Name: ${widget.plant.scientific_name!}',
                        style: style.InterSmallText(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 15),
                            fontweight: FontWeight.w400,
                            fontstyle: FontStyle.italic),
                      ),
                      const Divider(),
                      Gap(setResponsiveSize(context, baseSize: 25)),
                      Text(
                        '▣ DESCRIPTION:',
                        style: style.InterSmallText(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 15),
                            fontweight: FontWeight.w700),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      Text(
                        widget.plant.description!,
                        textAlign: TextAlign.justify,
                        style: style.InterSmallText(context,
                            color: color.primarylow,
                            height: setResponsiveSize(context, baseSize: 1.4),
                            fontsize: setResponsiveSize(context, baseSize: 15),
                            fontweight: FontWeight.w400),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 25)),
                      Text(
                        '▣ TREATMENT:',
                        style: style.InterSmallText(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 15),
                            fontweight: FontWeight.w700),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: setResponsiveSize(context, baseSize: 7),
                          runSpacing: setResponsiveSize(context, baseSize: 5),
                          children: widget.plant.treatments!
                              .asMap()
                              .entries
                              .map((entry) {
                            return IntrinsicWidth(
                              child: TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: color.primarylow,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          setResponsiveSize(context,
                                              baseSize: 5)),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  entry.value.name!,
                                  textAlign: TextAlign.justify,
                                  style: style.InterSmallText(
                                    context,
                                    color: color.primarylow,
                                    fontsize: setResponsiveSize(context,
                                        baseSize: 14),
                                    fontweight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 20)),
                      Text(
                        '▣ REMEDY:',
                        style: style.InterSmallText(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 15),
                            fontweight: FontWeight.w700),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      (ctRemedy.getRemedyTagByPlantId(widget.plant.id!).isEmpty)
                          ? Text(
                              '- No remedy found -',
                              style: style.InterSmallText(
                                context,
                                color: color.darkOpacity40,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 15),
                                fontweight: FontWeight.w400,
                                fontstyle: FontStyle.italic,
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                spacing:
                                    setResponsiveSize(context, baseSize: 7),
                                runSpacing: setResponsiveSize(context,
                                    baseSize: 5), // Vertical space between rows
                                children: ctRemedy
                                    .getRemedyTagByPlantId(widget.plant.id!)
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  return IntrinsicWidth(
                                    child: TextButton(
                                      onPressed: () {
                                        Get.to(() => RemedyInfoScreen(
                                            remedy: entry.value));
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            color.primarylow),
                                        shape: WidgetStatePropertyAll<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              setResponsiveSize(context,
                                                  baseSize: 5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        entry.value.name!,
                                        textAlign: TextAlign.justify,
                                        style: style.InterSmallText(
                                          context,
                                          color: color.white,
                                          fontsize: setResponsiveSize(context,
                                              baseSize: 14),
                                          fontweight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
