import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var agreedToTerms = false.obs;

  void toggleAgreement() {
    agreedToTerms.value = !agreedToTerms.value;
  }
}
