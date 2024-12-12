import 'package:arcore_flutter_plugin_example/models/data_model/md_plant.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_remedy.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin_example/models/plant_info.dart';
import 'package:arcore_flutter_plugin_example/models/remedy_info.dart';
import 'package:arcore_flutter_plugin_example/utils/_initApp.dart';
import 'package:arcore_flutter_plugin_example/utils/responsive.dart';
import 'dart:math'; // Import this for randomization

class RemedyPlantCarousel extends StatefulWidget {
  List<dynamic> combinedList;

  RemedyPlantCarousel({required this.combinedList});

  @override
  _RemedyPlantCarouselState createState() => _RemedyPlantCarouselState();
}

class _RemedyPlantCarouselState extends State<RemedyPlantCarousel>
    with Application {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Combine remedies and plants into one list and shuffle it

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: setResponsiveSize(context, baseSize: 10),
          horizontal: setResponsiveSize(context, baseSize: 18)),
      child: Row(
        children: [
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                height: setResponsiveSize(context, baseSize: 180),
                viewportFraction: 0.8,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
              ),
              items: widget.combinedList.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    if (item is RemedyModel) {
                      return Container(
                        child: Stack(
                          children: [
                            Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item.image_path![0],
                                    width: 250,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(5),
                                color: color.whiteOpacity20,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item.name!,
                                    style: style.displaySmall(context,
                                        color: color.white,
                                        fontsize: setResponsiveSize(context,
                                            baseSize: 15),
                                        fontweight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (item is PlantModel) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Stack(
                          children: [
                            Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item.images![0],
                                    width: 300,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(5),
                                color: color.whiteOpacity20,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: setResponsiveSize(context,
                                          baseSize: 10),
                                      vertical: setResponsiveSize(context,
                                          baseSize: 7)),
                                  child: Text(
                                    item.name!,
                                    style: style.displaySmall(context,
                                        color: color.white,
                                        fontsize: setResponsiveSize(context,
                                            baseSize: 15),
                                        fontweight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        child: Text('Unknown type'),
                      ); // Fallback in case of an unrecognized type
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
