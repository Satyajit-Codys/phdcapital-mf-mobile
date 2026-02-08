import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePinController extends GetxController {
  final int pinLength = 4;

  final pinControllers = List.generate(4, (_) => TextEditingController());
  final confirmControllers = List.generate(4, (_) => TextEditingController());

  final pinFocus = List.generate(4, (_) => FocusNode());
  final confirmFocus = List.generate(4, (_) => FocusNode());

  final RxBool isPinValid = false.obs;
  final RxInt pinStrength = 0.obs;

  final RxBool enableFingerprint = true.obs;
  final RxBool enableFaceLock = false.obs;

  @override
  void onInit() {
    for (final c in [...pinControllers, ...confirmControllers]) {
      c.addListener(_evaluatePin);
    }
    super.onInit();
  }

  void moveNext(List<FocusNode> nodes, int index) {
    if (index < nodes.length - 1) {
      nodes[index + 1].requestFocus();
    } else {
      nodes[index].unfocus();
    }
  }

  void _evaluatePin() {
    final pin = pinControllers.map((e) => e.text).join();
    final confirm = confirmControllers.map((e) => e.text).join();

    if (pin.length == 4) {
      pinStrength.value = _calculateStrength(pin);
    } else {
      pinStrength.value = 0;
    }

    // Allow ALL pins, only check match
    isPinValid.value = pin.length == 4 && confirm.length == 4 && pin == confirm;
  }

  int _calculateStrength(String pin) {
    final uniqueDigits = pin.split('').toSet().length;

    // Very weak (0000, 1111)
    if (uniqueDigits == 1) {
      return 1;
    }

    // Sequential (1234, 4321)
    if (_isSequential(pin)) {
      return 2;
    }

    // Strong
    return 3;
  }

  bool _isSequential(String pin) {
    const sequences = [
      '0123',
      '1234',
      '2345',
      '3456',
      '4567',
      '5678',
      '6789',
      '9876',
      '8765',
      '7654',
      '6543',
      '5432',
      '4321',
      '3210',
    ];
    return sequences.contains(pin);
  }

  @override
  void onClose() {
    for (final c in [...pinControllers, ...confirmControllers]) {
      c.dispose();
    }
    for (final f in [...pinFocus, ...confirmFocus]) {
      f.dispose();
    }
    super.onClose();
  }
}
