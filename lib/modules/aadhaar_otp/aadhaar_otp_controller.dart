import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AadhaarOtpController extends GetxController {
  final otpController = TextEditingController();

  final RxBool isOtpValid = true.obs;
  final RxBool isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    otpController.addListener(_validate);
  }

  void _validate() {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      isOtpValid.value = true;
      isFormValid.value = false;
      return;
    }

    isOtpValid.value = otp.length == 6;
    isFormValid.value = otp.length == 6;
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
