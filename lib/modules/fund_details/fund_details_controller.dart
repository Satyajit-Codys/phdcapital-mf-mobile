import 'package:get/get.dart';

class FundDetailsController extends GetxController {
  final RxBool isTaxInfoExpanded = true.obs;

  void toggleTaxInfo() {
    isTaxInfoExpanded.value = !isTaxInfoExpanded.value;
  }
}
