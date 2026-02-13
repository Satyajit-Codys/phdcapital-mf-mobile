import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SipInvestController extends GetxController {
  final RxString investmentType = 'SIP'.obs;
  final amountController = TextEditingController(text: '1,000');
  final RxString frequency = 'Monthly'.obs;
  final RxInt sipDate = 4.obs;
  final RxBool showFrequencyDropdown = false.obs;
  final RxInt amount = 1000.obs;

  final List<int> quickAmounts = [1000, 2000, 2500, 3000];
  final List<int> onetimeQuickAmounts = [5000, 10000, 15000, 25000];
  final List<String> frequencies = ['Monthly', 'Weekly'];

  @override
  void onInit() {
    super.onInit();
    amountController.text = '1,000';
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  void selectInvestmentType(String type) {
    investmentType.value = type;
    if (type == "One-Time") {
      amount.value = 5000;
      amountController.text = _formatAmount(5000);
    } else {
      amount.value = 1000;
      amountController.text = _formatAmount(1000);
    }
  }

  void selectQuickAmount(int amt) {
    amount.value = amt;
    amountController.text = _formatAmount(amt);
  }

  void selectFrequency(String freq) {
    frequency.value = freq;
    showFrequencyDropdown.value = false;
  }

  void toggleFrequencyDropdown() {
    showFrequencyDropdown.value = !showFrequencyDropdown.value;
  }

  void selectSipDate(BuildContext context) async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, sipDate.value),
      firstDate: DateTime(now.year, now.month, 1),
      lastDate: DateTime(now.year, now.month + 1, 0),
      selectableDayPredicate: (date) => date.month == now.month,
    );

    if (selectedDate != null) {
      sipDate.value = selectedDate.day;
    }
  }

  String _formatAmount(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  int get totalAmount => amount.value;

  double get estimatedReturns {
    final monthlyAmount = amount.value;
    const annualReturn = 0.277; // 27.7%
    const years = 3;
    const months = years * 12;
    final monthlyRate = annualReturn / 12;

    final futureValue =
        monthlyAmount *
        ((pow(1 + monthlyRate, months) - 1) / monthlyRate) *
        (1 + monthlyRate);

    return futureValue;
  }

  double pow(double base, int exponent) {
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }

  String get nextSipDate {
    final now = DateTime.now();
    DateTime nextDate;

    if (sipDate.value >= now.day) {
      nextDate = DateTime(now.year, now.month, sipDate.value);
    } else {
      nextDate = DateTime(now.year, now.month + 1, sipDate.value);
    }

    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${sipDate.value}th ${months[nextDate.month - 1]} ${nextDate.year}';
  }
}
