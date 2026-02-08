import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final int otpLength = 6;

  // -------------------------
  // PHONE / EMAIL
  // -------------------------
  final RxString phoneNumber = "".obs;

  String get maskedContact {
    final value = phoneNumber.value;

    // -------------------------
    // EMAIL MASKING
    // -------------------------
    if (value.contains("@")) {
      final parts = value.split("@");
      final username = parts[0];
      final domain = parts[1];

      // If username too short, don't mask
      if (username.length <= 4) {
        return value;
      }

      final start = username.substring(0, 2);
      final end = username.substring(username.length - 2);

      final maskedLength = username.length - 4;
      final masked = "*" * maskedLength;

      return "$start$masked$end@$domain";
    }

    // -------------------------
    // PHONE MASKING
    // -------------------------
    if (value.length <= 4) return value;

    return value.replaceRange(3, value.length - 2, "******");
  }

  // -------------------------
  // OTP CONTROLLERS
  // -------------------------
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  // -------------------------
  // STATE
  // -------------------------
  final RxBool isOtpComplete = false.obs;
  final RxInt secondsRemaining = 59.obs;

  Timer? _timer;

  @override
  void onInit() {
    // Receive phone/email from login screen
    phoneNumber.value = Get.arguments?["phone"] ?? "";

    _startTimer();

    for (final c in controllers) {
      c.addListener(_checkOtp);
    }

    super.onInit();
  }

  // -------------------------
  // OTP CHECK
  // -------------------------
  void _checkOtp() {
    isOtpComplete.value = controllers.every((c) => c.text.isNotEmpty);
  }

  // -------------------------
  // FOCUS HELPERS
  // -------------------------
  void moveToNext(int index) {
    if (index < otpLength - 1) {
      focusNodes[index + 1].requestFocus();
    } else {
      focusNodes[index].unfocus();
    }
  }

  void moveToPrevious(int index) {
    if (index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  // -------------------------
  // TIMER
  // -------------------------
  void _startTimer() {
    _timer?.cancel();
    secondsRemaining.value = 59;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  void resendOtp() {
    for (final c in controllers) {
      c.clear();
    }
    isOtpComplete.value = false;
    focusNodes.first.requestFocus();
    _startTimer();
  }

  @override
  void onClose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }
}
