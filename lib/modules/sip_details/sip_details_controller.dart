import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SipDetailsController extends GetxController {
  final RxDouble totalInvested = 0.0.obs;
  final RxDouble currentValue = 0.0.obs;
  final RxDouble returns = 0.0.obs;
  final RxDouble returnsPercentage = 0.0.obs;

  final TextEditingController modifyAmountController = TextEditingController();
  final Rx<DateTime> modifyDebitDate = DateTime.now().obs;
  final Rx<DateTime> resumeDate = DateTime.now().obs;
  final RxString pauseReason = ''.obs;
  final RxBool confirmCancel = false.obs;

  @override
  void onInit() {
    super.onInit();
    _calculateReturns();
  }

  void _calculateReturns() {
    // Mock calculation
    totalInvested.value = 50000;
    currentValue.value = 58500;
    returns.value = currentValue.value - totalInvested.value;
    returnsPercentage.value = (returns.value / totalInvested.value) * 100;
  }

  void showModifySipSheet() {
    Get.bottomSheet(
      _buildModifySipSheet(),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }

  void showPauseSipSheet() {
    Get.bottomSheet(
      _buildPauseSipSheet(),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }

  void showCancelSipSheet() {
    Get.bottomSheet(
      _buildCancelSipSheet(),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }

  Widget _buildModifySipSheet() {
    return Container();
  }

  Widget _buildPauseSipSheet() {
    return Container();
  }

  Widget _buildCancelSipSheet() {
    return Container();
  }

  @override
  void onClose() {
    modifyAmountController.dispose();
    super.onClose();
  }
}
