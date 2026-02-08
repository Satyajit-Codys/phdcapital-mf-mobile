import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final phoneOrEmailController = TextEditingController();

  final RxBool isValid = false.obs;

  void validateInput(String value) {
    final input = value.trim();

    if (input.isEmpty) {
      isValid.value = false;
      return;
    }

    // Check phone or email
    if (_isValidPhone(input) || _isValidEmail(input)) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
  }

  // -------------------------
  // PHONE VALIDATION
  // -------------------------
  bool _isValidPhone(String input) {
    final phoneRegex = RegExp(r'^(?:\+91)?[6-9]\d{9}$');
    return phoneRegex.hasMatch(input);
  }

  // -------------------------
  // EMAIL VALIDATION
  // -------------------------
  bool _isValidEmail(String input) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(input);
  }

  @override
  void onClose() {
    phoneOrEmailController.dispose();
    super.onClose();
  }
}
