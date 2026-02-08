import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDetailsController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();

  final RxnString gender = RxnString();
  final RxnString maritalStatus = RxnString();
  final RxnString occupation = RxnString();
  final RxnString incomeRange = RxnString();

  final RxBool isFormValid = false.obs;
  final RxBool isEmailValid = true.obs; // 👈 ADD

  @override
  void onInit() {
    super.onInit();

    fullNameController.addListener(validateForm);
    emailController.addListener(validateForm);

    everAll([
      gender,
      maritalStatus,
      occupation,
      incomeRange,
    ], (_) => validateForm());
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void validateForm() {
    final email = emailController.text.trim();

    isEmailValid.value = email.isEmpty ? true : _isValidEmail(email);

    isFormValid.value =
        fullNameController.text.isNotEmpty &&
        email.isNotEmpty &&
        isEmailValid.value &&
        gender.value != null &&
        maritalStatus.value != null &&
        occupation.value != null &&
        incomeRange.value != null;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.onClose();
  }
}
