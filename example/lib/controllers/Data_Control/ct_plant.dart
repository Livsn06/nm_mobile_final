import 'package:get/get.dart';

import '../../api/api_plant.dart';
import '../../constants/_savedData.dart';

class CtPlant extends GetxController {
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    var response = await PlantApi.fetchAllPlants();
    if (response != null) {
      ALL_PLANTS_DATA.value = response;
      print('ALL_PLANTS_DATA: ${ALL_PLANTS_DATA.value.length}');
    }
    ALL_PLANTS_DATA.value = response ?? [];
  }
}
