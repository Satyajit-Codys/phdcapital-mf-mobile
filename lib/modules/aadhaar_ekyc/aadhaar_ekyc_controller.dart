import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AadhaarEkycController extends GetxController {
  final aadhaarController = TextEditingController();

  final RxBool isAadhaarValid = true.obs;
  final RxBool consentGiven = false.obs;
  final RxBool isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    aadhaarController.addListener(_validate);

    // 🔥 THIS IS THE MISSING PIECE
    ever(consentGiven, (_) => _validate());
  }

  void _validate() {
    final aadhaar = aadhaarController.text.trim();

    isAadhaarValid.value = aadhaar.isEmpty
        ? true
        : RegExp(r'^\d{12}$').hasMatch(aadhaar);

    isFormValid.value =
        isAadhaarValid.value && aadhaar.length == 12 && consentGiven.value;
  }

  @override
  void onClose() {
    aadhaarController.dispose();
    super.onClose();
  }
}
