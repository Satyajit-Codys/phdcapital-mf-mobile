import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    print('Changing tab to: $index'); // Debug
    currentIndex.value = index;
    print('Current index is now: ${currentIndex.value}'); // Debug
  }
}
