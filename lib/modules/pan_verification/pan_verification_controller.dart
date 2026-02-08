import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanVerificationController extends GetxController {
  final panHolderNameController = TextEditingController();
  final panController = TextEditingController();

  final RxString panText = ''.obs; // ✅ ADD THIS
  final RxBool isPanValid = false.obs;
  final RxBool isVerifying = false.obs;
  final RxBool isVerified = false.obs;

  @override
  void onInit() {
    super.onInit();
    panController.addListener(_validatePan);
  }

  void _validatePan() {
    final pan = panController.text.trim().toUpperCase();

    panController.value = panController.value.copyWith(
      text: pan,
      selection: TextSelection.collapsed(offset: pan.length),
    );

    panText.value = pan; // ✅ observable update
    isPanValid.value = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(pan);

    isVerified.value = false;
  }

  Future<void> verifyPan() async {
    if (!isPanValid.value) return;

    isVerifying.value = true;
    await Future.delayed(const Duration(seconds: 3));
    isVerifying.value = false;
    isVerified.value = true;
  }

  @override
  void onClose() {
    panHolderNameController.dispose();
    panController.dispose();
    super.onClose();
  }
}
