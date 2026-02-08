import 'package:get/get.dart';

class LanguageController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final languages = [
    {"title": "English (United States)", "subtitle": "English (United States)"},
    {"title": "Cestina", "subtitle": "Czech"},
    {"title": "Dansk", "subtitle": "Danish"},
    {"title": "Nedarlands(Belgie)", "subtitle": "Dutch (Belgium)"},
    {"title": "English (Australia)", "subtitle": "English (Australia)"},
    {
      "title": "English (United Kingdom)",
      "subtitle": "English (United Kingdom)",
    },
  ];

  void selectLanguage(int index) {
    selectedIndex.value = index;
  }
}
