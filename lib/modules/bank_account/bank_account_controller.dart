import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankAccountController extends GetxController {
  final accountHolderController = TextEditingController();
  final accountNumberController = TextEditingController();
  final reAccountNumberController = TextEditingController();
  final ifscController = TextEditingController();
  final bankNameController = TextEditingController();

  final RxBool isPrimary = true.obs;

  final RxBool isIfscValid = true.obs;
  final RxBool isAccountMatch = true.obs;
  final RxBool isAccountNumberValid = true.obs;
  final RxBool isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    accountHolderController.addListener(validateForm);
    accountNumberController.addListener(validateForm);
    reAccountNumberController.addListener(validateForm);
    ifscController.addListener(validateForm);

    validateForm();
  }

  bool _isValidAccountNumber(String acc) {
    return RegExp(r'^[0-9]{9,18}$').hasMatch(acc);
  }

  bool _isValidIfsc(String ifsc) {
    return RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifsc);
  }

  void validateForm() {
    final holder = accountHolderController.text.trim();
    final acc = accountNumberController.text.trim();
    final reAcc = reAccountNumberController.text.trim();
    final ifsc = ifscController.text.trim().toUpperCase();

    // Account number validation
    isAccountNumberValid.value = acc.isEmpty
        ? true
        : _isValidAccountNumber(acc);

    // Match validation (only after re-enter starts)
    if (reAcc.isEmpty) {
      isAccountMatch.value = true;
    } else {
      isAccountMatch.value = acc == reAcc;
    }

    // IFSC validation
    if (ifsc.isEmpty) {
      isIfscValid.value = true;
      bankNameController.clear();
    } else {
      isIfscValid.value = _isValidIfsc(ifsc);
      bankNameController.text = isIfscValid.value ? "HDFC Bank" : "";
    }

    isFormValid.value =
        holder.isNotEmpty &&
        isAccountNumberValid.value &&
        isAccountMatch.value &&
        isIfscValid.value &&
        acc.isNotEmpty &&
        reAcc.isNotEmpty;
  }

  @override
  void onClose() {
    accountHolderController.dispose();
    accountNumberController.dispose();
    reAccountNumberController.dispose();
    ifscController.dispose();
    bankNameController.dispose();
    super.onClose();
  }
}
