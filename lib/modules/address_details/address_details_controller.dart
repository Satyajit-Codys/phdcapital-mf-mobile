import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/data/india_states_cities.dart';

class AddressDetailsController extends GetxController {
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final pincodeController = TextEditingController();

  // 🔽 Dropdown selections
  final RxnString selectedState = RxnString();
  final RxnString selectedCity = RxnString();

  final RxBool sameAsCurrent = false.obs;
  final RxBool isFormValid = false.obs;
  final RxBool isPincodeValid = false.obs;

  // -----------------------------
  // DATA
  // -----------------------------
  List<String> get states => indiaStatesAndCities.keys.toList();

  List<String> get cities {
    if (selectedState.value == null) return [];
    return indiaStatesAndCities[selectedState.value] ?? [];
  }

  // -----------------------------
  // LIFECYCLE
  // -----------------------------
  @override
  @override
  void onInit() {
    super.onInit();

    addressLine1Controller.addListener(validateForm);
    pincodeController.addListener(_validatePincode);

    everAll([
      selectedState,
      selectedCity,
      isPincodeValid,
    ], (_) => validateForm());
  }

  // -----------------------------
  // ACTIONS
  // -----------------------------

  void _validatePincode() {
    final pin = pincodeController.text.trim();

    isPincodeValid.value = RegExp(r'^[1-9][0-9]{5}$').hasMatch(pin);

    validateForm();
  }

  void onStateSelected(String state) {
    selectedState.value = state;
    selectedCity.value = null; // 🚨 reset city
  }

  void onCitySelected(String city) {
    selectedCity.value = city;
  }

  // -----------------------------
  // VALIDATION
  // -----------------------------
  void validateForm() {
    isFormValid.value =
        addressLine1Controller.text.trim().isNotEmpty &&
        selectedState.value != null &&
        selectedCity.value != null &&
        isPincodeValid.value;
  }

  // -----------------------------
  // CLEANUP
  // -----------------------------
  @override
  void onClose() {
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    pincodeController.dispose();
    super.onClose();
  }
}
