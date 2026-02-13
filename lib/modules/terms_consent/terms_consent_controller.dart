import 'package:get/get.dart';

class TermsConsentController extends GetxController {
  final RxBool agreedToTerms = false.obs;

  void toggleAgreement() {
    agreedToTerms.value = !agreedToTerms.value;
  }

  bool get canProceed => agreedToTerms.value;
}
