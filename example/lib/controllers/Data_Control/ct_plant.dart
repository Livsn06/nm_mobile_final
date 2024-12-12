import 'package:arcore_flutter_plugin_example/constants/global_adds.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_plant.dart';
import 'package:get/get.dart';

import '../../api/api_plant.dart';
import '../../constants/_savedData.dart';

class CtPlant extends GetxController {
  @override
  void onInit() {
    loadData();

    super.onInit();
  }

  @override
  void onClose() {
    isOpenCamera.value = false;
    super.onClose();
  }

  void loadData() async {
    var response = await PlantApi.fetchAllPlants();
    if (response != null) {
      ALL_PLANTS_DATA.value = response;
      print('ALL_PLANTS_DATA: ${ALL_PLANTS_DATA.value.length}');
      sortPlantByHighestLike();
    }
  }

  void sortPlantByHighestLike() {
    ALL_PLANT_SORT_BY_LIKES.value = ALL_PLANTS_DATA.value;
    print('ALL_PLANT_SORT_BY_LIKES: ${ALL_PLANT_SORT_BY_LIKES.value.length}');

    //SORT FROM HIGHEST TO LOWEST
    ALL_PLANT_SORT_BY_LIKES.value
        .sort((a, b) => b.total_likes!.compareTo(a.total_likes!));

    // print('first plant: ${ALL_PLANT_SORT_BY_LIKES.value[0].name}');
  }

  PlantModel? getPlantByScientificName(String? scientificName) {
    if (scientificName == null) return null;
    var plant = ALL_PLANTS_DATA.value.firstWhere(
      (plant) =>
          plant.scientific_name!.toLowerCase() == scientificName.toLowerCase(),
      orElse: () => PlantModel(),
    );

    return plant.id != null ? plant : null;
  }
}
