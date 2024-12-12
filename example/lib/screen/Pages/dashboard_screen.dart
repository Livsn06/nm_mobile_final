import 'package:arcore_flutter_plugin_example/constants/_savedData.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_plant.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_remedy.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:arcore_flutter_plugin_example/components/cust_carousel.dart';
import 'package:arcore_flutter_plugin_example/controllers/PlantInfo_Control/plantInfos_controller.dart';
import 'package:arcore_flutter_plugin_example/controllers/Home_Control/dashboard_controller.dart';
import 'package:arcore_flutter_plugin_example/utils/_initApp.dart';
import 'package:arcore_flutter_plugin_example/utils/responsive.dart';
import '../../components/cust_cardlist.dart';
import '../../components/cust_category.dart';
import '../../constants/global_adds.dart';
import '../../controllers/Home_Control/bookmark_controller.dart';
import '../../models/plant_info.dart';
import '../../routes/screen_routes.dart';

class DashboardScreen extends StatefulWidget with Application {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with Application {
  final _selectControl = TextEditingController();
  final ctDashboard = Get.put(DashboardController());
  final plantController = Get.put(PlantInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.light,
        body: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCategoryChips(context),
                    Obx(() {
                      // Combine remedies and plants TO CREATE CAROUSEL DATA
                      ALL_REMEDY_PLANT_COMBINE_DATA.value.clear();
                      ALL_REMEDY_PLANT_COMBINE_DATA.value
                          .addAll(ALL_PLANTS_DATA.value);
                      ALL_REMEDY_PLANT_COMBINE_DATA.value
                          .addAll(ALL_REMEDIES_DATA.value);

                      return RemedyPlantCarousel(
                        combinedList: ALL_REMEDY_PLANT_COMBINE_DATA..shuffle(),
                      );
                    }),
                    ..._buildContent(context),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  List<Widget> _buildContent(BuildContext context) {
    return [
      if (_isCategorySelected(ctDashboard, 'All', 'Future Remedies'))
        _buildFutureRemedies(context),
      if (_isCategorySelected(ctDashboard, 'All', 'Plants'))
        _buildPopularHerbalPlant(context),
      if (_isCategorySelected(ctDashboard, 'All', 'Recommendation'))
        _buildRecommendedHerbalPlant(context),
      SizedBox(height: setResponsiveSize(context, baseSize: 80)),
    ];
  }

  bool _isCategorySelected(DashboardController controller,
      String defaultCategory, String specificCategory) {
    return controller.selectedCategory.value == defaultCategory ||
        controller.selectedCategory.value == specificCategory;
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: setResponsiveSize(context, baseSize: 205),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.primary,
              color.primarylow,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft:
                  Radius.circular(setResponsiveSize(context, baseSize: 20)),
              bottomRight:
                  Radius.circular(setResponsiveSize(context, baseSize: 20)))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: setResponsiveSize(context, baseSize: 10),
            horizontal: setResponsiveSize(context, baseSize: 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(setResponsiveSize(context, baseSize: 30)),
            _buildTitleRow(context),
            Gap(setResponsiveSize(context, baseSize: 10)),
            Text(
              ctDashboard.greeting.value,
              style: style.displaySmall(context,
                  color: color.white,
                  fontsize: 22,
                  fontweight: FontWeight.w800),
            ),
            Gap(setResponsiveSize(context, baseSize: 15)),
            _buildSearchBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(logo.second,
            scale: setResponsiveSize(context, baseSize: 8)),
        CircleAvatar(
          backgroundColor: color.primarylow,
          radius: setResponsiveSize(context, baseSize: 15) +
              setResponsiveSize(context, baseSize: 4),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: setResponsiveSize(context, baseSize: 18),
            child: Icon(Icons.notifications_outlined,
                color: color.primarylow,
                size: setResponsiveSize(context, baseSize: 25)),
          ),
        )
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Row(
      children: [
        Expanded(
            child: InkWell(
          onTap: () => controller.goToSearch(),
          child: Material(
            borderRadius:
                BorderRadius.circular(setResponsiveSize(context, baseSize: 10)),
            elevation: 4,
            child: TextFormField(
              enabled: false,
              controller: _selectControl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: setResponsiveSize(context, baseSize: 12),
                  horizontal: setResponsiveSize(context, baseSize: 12),
                ),
                border: controller.borderCust,
                enabledBorder: controller.borderCust,
                focusedBorder: controller.borderCust,
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search,
                    color: color.primarylow,
                    size: setResponsiveSize(context, baseSize: 25)),
              ),
            ),
          ),
        )),
        Gap(setResponsiveSize(context, baseSize: 10)),
        Material(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  setResponsiveSize(context, baseSize: 7))),
          child: Padding(
            padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 10)),
            child: Icon(Icons.filter_alt_outlined,
                color: color.primarylow,
                size: setResponsiveSize(context, baseSize: 25)),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: setResponsiveSize(
            context,
            baseSize: 15,
          ),
          horizontal: setResponsiveSize(context, baseSize: 15)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ['All', 'Future Remedies', 'Plants', 'Recommendation']
              .map((label) => CategoryChip(label))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildFutureRemedies(BuildContext context) {
    return Obx(() {
      // Build the section with the sorted remedies list
      return _buildSection(
        context,
        title: 'Future Remedies',
        items: ALL_REMEDY_SORT_BY_RATINGS.value.map((remedy) {
          return _buildRemedyCard(
            context,
            remedy,
          );
        }).toList(),
      );
    });
  }

  Widget _buildPopularHerbalPlant(BuildContext context) {
    return Obx(() {
      // Build the section with the sorted plants list
      return _buildSection(
        context,
        title: 'Popular Herbal Plant',
        items: ALL_PLANT_SORT_BY_LIKES.value.map((plant) {
          return _PopularHerbalPlantCard(context, plant);
        }).toList(),
      );
    });
  }

  Widget _buildRecommendedHerbalPlant(BuildContext context) {
    return Obx(() {
      return _buildSection(
        context,
        title: 'Recommended Herbal Plant',
        items: ALL_PLANTS_DATA.value
            .map((plant) => _RecommendedHerbalPlantCard(context, plant))
            .toList(),
      );
    });
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<Widget> items}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: setResponsiveSize(context, baseSize: 20),
          horizontal: setResponsiveSize(context, baseSize: 15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, title),
          Divider(),
          SizedBox(
            height: setResponsiveSize(context, baseSize: 260),
            child: ListView(scrollDirection: Axis.horizontal, children: items),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: style.displaySmall(context,
              color: color.darkGrey,
              fontsize: setResponsiveSize(context, baseSize: 15),
              fontweight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: () {
            // if (title == 'Future Remedies') {
            //   // Pass remedyList for Future Remedies
            //   controller.gotoSeeAll(plantList, title);
            // } else if (title == 'Popular Herbal Plant') {
            //   // Pass plantList for Popular Herbal Plant
            //   controller.gotoSeeAll(plantList, title);
            // } else {
            //   // Default, pass plantList or appropriate list for Recommendation
            //   controller.gotoSeeAll(plantList, title);
            // }
          },
          child: Text(
            'See all',
            style: style.displaySmall(context,
                color: color.primary,
                fontsize: setResponsiveSize(context, baseSize: 14),
                fontweight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _PopularHerbalPlantCard(BuildContext context, PlantModel plant) {
    bool isBookmarked = false; //bookmarkController.isPlantBookmarked(plant);
    return GestureDetector(
      onTap: () {
        ctDashboard.selectPlant(plant, context);
      },
      child: Stack(
        children: [
          PopularHerbalPlantCard(
            imagePath: plant.images![0],
            title: plant.name!,
            description: plant.scientific_name!,
            bookmarkIcon:
                isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            onBookmarkTap: () {
              // if (isBookmarked) {
              //   bookmarkController.removeBookmark(plant, context);
              // } else {
              //   bookmarkController.addBookmark(plant);
              // }
            },
            totalReactions: plant.total_likes!,
          ),
        ],
      ),
    );
  }

  Widget _RecommendedHerbalPlantCard(BuildContext context, PlantModel plant) {
    bool isBookmarked = false; //bookmarkController.isPlantBookmarked(plant);
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          RecommendedPlantCard(
            imagePath: plant.images![0],
            title: plant.name!,
            description: plant.scientific_name!,
            bookmarkIcon:
                isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            onBookmarkTap: () {
              // if (isBookmarked) {
              //   bookmarkController.removeBookmark(plant, context);
              // } else {
              //   bookmarkController.addBookmark(plant);
              // }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRemedyCard(BuildContext context, RemedyModel remedy) {
    final bookmarkController = Get.put(BookmarkController());

    bool isBookmarked = false;
    return GestureDetector(
      onTap: () {
        ctDashboard.selectRemedy(remedy, context);
      },
      child: Stack(
        children: [
          RemedyPlantCard(
            imagePath: remedy.image_path![0],
            title: remedy.name!,
            description: remedy.type!,
            bookmarkIcon:
                isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            onBookmarkTap: () {
              // if (isBookmarked) {
              //   bookmarkController.removeRemedyBookmark(remedy, context);
              // } else {
              //   bookmarkController.addRemedyBookmark();
              // }
            },
            rating: remedy.average_rating!,
          ),
        ],
      ),
    );
  }
}
