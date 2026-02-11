import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    debugPrint('Changing tab to: $index'); // Debug
    currentIndex.value = index;
    debugPrint('Current index is now: ${currentIndex.value}'); // Debug
  }
}
