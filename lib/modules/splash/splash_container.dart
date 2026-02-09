import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // 1. Wait for 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      // 2. Navigate to Get Started and remove Splash from history
      Get.toNamed("/welcome");
    });
  }
}
