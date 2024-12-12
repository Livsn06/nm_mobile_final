import 'package:arcore_flutter_plugin_example/models/data_model/md_image.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_plant.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_remedy.dart';
import 'package:get/get.dart';

RxList<PlantModel> ALL_PLANTS_DATA = <PlantModel>[].obs;
RxList<RemedyModel> ALL_REMEDIES_DATA = <RemedyModel>[].obs;
RxList<dynamic> ALL_REMEDY_PLANT_COMBINE_DATA = <dynamic>[].obs;
RxList<RemedyModel> ALL_REMEDY_SORT_BY_RATINGS = <RemedyModel>[].obs;
RxList<PlantModel> ALL_PLANT_SORT_BY_LIKES = <PlantModel>[].obs;
Rx<dynamic> CURRENT_VIEWED_DATA = Rx<dynamic>([]).obs;

RxList<RemedyModel> ALL_REMEDY_TAGGED_BY_PLANT = <RemedyModel>[].obs;
