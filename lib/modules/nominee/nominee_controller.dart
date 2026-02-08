import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/modules/nominee/nominee_model.dart';

class NomineeController extends GetxController {
  static const int maxNominees = 10;

  // FORM controllers (for CURRENT nominee being edited)
  final nomineeNameController = TextEditingController();
  final dobController = TextEditingController();
  final shareController = TextEditingController();
  final guardianNameController = TextEditingController();
  final guardianPanController = TextEditingController();
  final nomineeAddressLine1Controller = TextEditingController();
  final nomineeAddressLine2Controller = TextEditingController();

  // FORM state
  final RxnString relationship = RxnString();
  final RxBool isMinor = false.obs;
  final RxBool consentChecked = false.obs;
  final RxBool isFormValid = false.obs;
  final RxString panText = ''.obs;
  final RxBool isPanVerified = false.obs;
  final RxBool isPanValid = false.obs;

  // ✅ SAVED NOMINEES
  final RxList<Nominee> nominees = <Nominee>[].obs;

  @override
  void onInit() {
    super.onInit();

    nomineeNameController.addListener(validateForm);
    shareController.addListener(validateForm);
    guardianNameController.addListener(validateForm);
    guardianPanController.addListener(validateForm);
    guardianPanController.addListener(_validatePan);

    everAll([relationship, isMinor, consentChecked], (_) => validateForm());
  }

  bool get canAddMoreNominees => nominees.length < maxNominees;

  void _validatePan() {
    if (!isMinor.value) {
      isPanValid.value = true;
      return;
    }

    final pan = guardianPanController.text.trim().toUpperCase();

    guardianPanController.value = guardianPanController.value.copyWith(
      text: pan,
      selection: TextSelection.collapsed(offset: pan.length),
    );

    panText.value = pan;
    isPanValid.value = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(pan);

    validateForm();
  }

  int get totalShare => nominees.fold(0, (sum, n) => sum + n.share);

  bool _isMinorFromDob(DateTime dob) {
    final today = DateTime.now();
    int age = today.year - dob.year;

    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age < 18;
  }

  void setDob(DateTime date) {
    dobController.text =
        "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}";

    isMinor.value = _isMinorFromDob(date);
    validateForm();
  }

  final RxInt editingIndex = (-1).obs;

  bool get isEditing => editingIndex.value != -1;

  void saveNominee() {
    if (!isFormValid.value) return;

    final nominee = Nominee(
      name: nomineeNameController.text.trim(),
      dob: _parseDob(),
      relationship: relationship.value!,
      share: int.parse(shareController.text),
      isMinor: isMinor.value,
      guardianName: isMinor.value ? guardianNameController.text.trim() : null,
      guardianPan: isMinor.value ? guardianPanController.text.trim() : null,
      addressLine1: nomineeAddressLine1Controller.text.trim().isEmpty
          ? null
          : nomineeAddressLine1Controller.text.trim(),
      addressLine2: nomineeAddressLine2Controller.text.trim().isEmpty
          ? null
          : nomineeAddressLine2Controller.text.trim(),
    );

    if (isEditing) {
      nominees[editingIndex.value] = nominee;
      editingIndex.value = -1; // exit edit mode
    } else {
      if (nominees.length >= maxNominees) return;
      nominees.add(nominee);
    }

    _resetForm();
  }

  void editNominee(int index) {
    final n = nominees[index];

    editingIndex.value = index;

    nomineeNameController.text = n.name;
    dobController.text =
        "${n.dob.day.toString().padLeft(2, '0')}-"
        "${n.dob.month.toString().padLeft(2, '0')}-"
        "${n.dob.year}";

    relationship.value = n.relationship;
    shareController.text = n.share.toString();

    isMinor.value = n.isMinor;

    guardianNameController.text = n.guardianName ?? "";
    guardianPanController.text = n.guardianPan ?? "";

    nomineeAddressLine1Controller.text = n.addressLine1 ?? "";
    nomineeAddressLine2Controller.text = n.addressLine2 ?? "";

    consentChecked.value = true;

    validateForm();
  }

  bool get hasAtLeastOneNominee => nominees.isNotEmpty;

  bool get isTotalShareValid => totalShare == 100;

  DateTime _parseDob() {
    final parts = dobController.text.split("-");
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  void _resetForm() {
    nomineeNameController.clear();
    dobController.clear();
    shareController.text = "";
    guardianNameController.clear();
    guardianPanController.clear();
    nomineeAddressLine1Controller.clear();
    nomineeAddressLine2Controller.clear();

    relationship.value = null;
    isMinor.value = false;
    consentChecked.value = false;

    validateForm();
  }

  void validateForm() {
    final share = int.tryParse(shareController.text);

    final nomineeValid =
        nomineeNameController.text.trim().isNotEmpty &&
        dobController.text.isNotEmpty &&
        relationship.value != null &&
        share != null &&
        share > 0 &&
        share <= 100;

    final guardianValid =
        !isMinor.value ||
        (guardianNameController.text.trim().isNotEmpty &&
            RegExp(
              r'^[A-Z]{5}[0-9]{4}[A-Z]$',
            ).hasMatch(guardianPanController.text.trim()));

    isFormValid.value = nomineeValid && guardianValid && consentChecked.value;
  }

  @override
  void onClose() {
    nomineeNameController.dispose();
    dobController.dispose();
    shareController.dispose();
    guardianNameController.dispose();
    guardianPanController.dispose();
    nomineeAddressLine1Controller.dispose();
    nomineeAddressLine2Controller.dispose();
    super.onClose();
  }
}
