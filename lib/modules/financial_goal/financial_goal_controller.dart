import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinancialGoalController extends GetxController {
  final RxString selectedGoal = ''.obs;
  final targetAmountController = TextEditingController();
  final RxDouble timeHorizon = 10.0.obs;
  final RxInt estimatedSip = 0.obs;

  final List<Map<String, String>> goals = [
    {'title': 'Buy a Home', 'icon': 'home_color_icon'},
    {'title': 'Education', 'icon': 'education_color_icon'},
    {'title': 'Travel', 'icon': 'travel_color_icon'},
    {'title': 'Wedding', 'icon': 'wedding_color_icon'},
    {'title': 'Retirement', 'icon': 'person_color_icon'},
    {'title': 'Custom', 'icon': 'star_color_icon'},
  ];

  @override
  void onInit() {
    super.onInit();
    targetAmountController.addListener(_calculateSip);
  }

  @override
  void onClose() {
    targetAmountController.dispose();
    super.onClose();
  }

  void selectGoal(String goal) {
    selectedGoal.value = goal;
  }

  void updateTimeHorizon(double value) {
    timeHorizon.value = value;
    _calculateSip();
  }

  void _calculateSip() {
    final targetText = targetAmountController.text.replaceAll(',', '');
    final target = double.tryParse(targetText) ?? 0;

    if (target <= 0) {
      estimatedSip.value = 0;
      return;
    }

    // Assuming 12% annual return
    const annualReturn = 0.12;
    final monthlyRate = annualReturn / 12;
    final months = timeHorizon.value * 12;

    // SIP formula: FV = P * [((1 + r)^n - 1) / r] * (1 + r)
    // Rearranged: P = FV / ([((1 + r)^n - 1) / r] * (1 + r))
    final denominator =
        ((pow(1 + monthlyRate, months) - 1) / monthlyRate) * (1 + monthlyRate);

    final monthlySip = target / denominator;
    estimatedSip.value = monthlySip.round();
  }

  bool get canProceed =>
      selectedGoal.value.isNotEmpty &&
      targetAmountController.text.isNotEmpty &&
      estimatedSip.value > 0;
}
