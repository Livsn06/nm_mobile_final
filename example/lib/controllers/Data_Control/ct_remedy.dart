import 'package:get/get.dart';

import '../../api/api_remedy.dart';
import '../../constants/_savedData.dart';
import '../../models/data_model/md_remedy.dart';

class CtRemedy extends GetxController {
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    var response = await RemedyApi.fetchAllRemedies();
    if (response != null) {
      //FETCH ALL REMEDIES
      ALL_REMEDIES_DATA.value = response;
      print('ALL_REMEDIES_DATA: ${ALL_REMEDIES_DATA.value.length}');

      //SORT FROM HIGHEST TO LOWEST
      sortRemedyByHighestRating();
    }
  }

  void sortRemedyByHighestRating() {
    ALL_REMEDY_SORT_BY_RATINGS.value = ALL_REMEDIES_DATA.value;
    print(
        'ALL_REMEDY_SORT_BY_RATINGS: ${ALL_REMEDY_SORT_BY_RATINGS.value.length}');
    //SORT FROM HIGHEST TO LOWEST
    ALL_REMEDY_SORT_BY_RATINGS.value
        .sort((a, b) => b.average_rating!.compareTo(a.average_rating!));
  }

  List<RemedyModel> getRemedyTagByPlantId(int plantId) {
    List<RemedyModel> remedyList = [];
    for (var remedy in ALL_REMEDIES_DATA.value) {
      for (var plant in remedy.tagged_plants!) {
        if (plant.id == plantId) {
          remedyList.add(remedy);
        }
      }
    }
    ALL_REMEDY_TAGGED_BY_PLANT.value = remedyList;
    print(
        'ALL_REMEDY_TAGGED_BY_PLANT: ${ALL_REMEDY_TAGGED_BY_PLANT.value.length}');
    return remedyList;
  }
}
