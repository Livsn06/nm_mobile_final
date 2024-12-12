import 'package:get/get.dart';

import '../../api/api_request.dart';
import '../../models/data_model/md_request_plant.dart';

class RequestPlantController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    ();
  }

  RxList<RequestPlantModel> requestPlantData = RxList<RequestPlantModel>([]);

  Future<void> loadRequests() async {
    requestPlantData.value = await RequestApi.fetchAllRequests() ?? [];
  }
}
