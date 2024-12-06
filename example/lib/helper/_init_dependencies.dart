import 'package:get/get.dart';
import 'package:arcore_flutter_plugin_example/controllers/Home_Control/clientrqst_controller.dart';
import 'package:arcore_flutter_plugin_example/controllers/Home_Control/dashboard_controller.dart';
import 'package:arcore_flutter_plugin_example/controllers/WalkThru_Control/onboarding_controller.dart';
import 'package:arcore_flutter_plugin_example/controllers/WalkThru_Control/splash_controller.dart';
import '../controllers/Auth_Control/forgetpassword_controller.dart';
import '../controllers/Home_Control/bookmark_controller.dart';
import '../controllers/Home_Control/home_controller.dart';
import '../controllers/Auth_Control/login_controller.dart';
import '../controllers/Internet_Control/internet_controller.dart';
import '../controllers/Home_Control/profile_controller.dart';
import '../controllers/Auth_Control/register_controller.dart';
import '../controllers/PlantInfo_Control/plantInfos_controller.dart';
import '../controllers/Remedy_Control/remedy_controller.dart';
import '../controllers/Search_Controller/search_controller.dart';

class InitDep implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies'
    Get.lazyPut(() => OnboardingController());
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => PlantInfoController());
    Get.lazyPut(() => RemedyController());
    Get.lazyPut(() => BookmarkController());
    Get.lazyPut(() => ClientRequestController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => SearchingController());
    Get.lazyPut(() => InternetController());
    Get.lazyPut(() => ForgetPasswordController());
  }
}
