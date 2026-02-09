import 'dart:async';

import 'package:get/get.dart';

enum BankVerificationStatus { inProgress, success, failed }

class BankVerificationController extends GetxController {
  final Rx<BankVerificationStatus> status =
      BankVerificationStatus.inProgress.obs;

  // 👇 DATA FROM PREVIOUS SCREEN
  late final String bankName;
  late final String accountHolder;
  late final String accountNoMasked;
  late final String ifsc;

  @override
  void onInit() {
    super.onInit();
    _startVerification();
    final args = Get.arguments as Map<String, dynamic>;

    bankName = args["bankName"];
    accountHolder = args["accountHolder"];
    ifsc = args["ifsc"];

    final accNo = args["accountNumber"] as String;
    accountNoMasked = _maskAccountNumber(accNo);

    // TODO: call verification API here
  }

  void _startVerification() {
    // ⏳ Dummy delay for now
    Timer(const Duration(seconds: 3), () {
      status.value = BankVerificationStatus.success;
      // 🔴 future:
      // status.value = BankVerificationStatus.failed;
    });
  }

  String _maskAccountNumber(String acc) {
    if (acc.length <= 4) return acc;
    return "**** **** ${acc.substring(acc.length - 4)}";
  }

  // Mock helpers
  void markSuccess() {
    status.value = BankVerificationStatus.success;
  }

  void markFailed() {
    status.value = BankVerificationStatus.failed;
  }
}
