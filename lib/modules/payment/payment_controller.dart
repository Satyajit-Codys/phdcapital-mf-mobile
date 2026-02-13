import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_text_styles.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_button_enum.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_input_enum.dart';
import 'package:phdcapital_mf_mobile/widgets/app_button.dart';
import 'package:phdcapital_mf_mobile/widgets/app_input.dart';
import '../../app/routes.dart';

class PaymentController extends GetxController {
  final RxString selectedPaymentMethod = ''.obs;
  final upiIdController = TextEditingController();

  /// Validation state
  final RxBool isUpiValid = false.obs;
  final RxBool hasUserTyped = false.obs;
  final RxBool hasUserTypedUpi = false.obs;

  final int amount;
  final String fundName;

  PaymentController({
    required this.amount,
    this.fundName = 'Axis Blue-chip Fund',
  });

  @override
  void onInit() {
    super.onInit();

    upiIdController.addListener(() {
      final text = upiIdController.text.trim().toLowerCase();
      hasUserTypedUpi.value = text.isNotEmpty;
      validateUpi(text);
    });
  }

  @override
  void onClose() {
    upiIdController.dispose();
    super.onClose();
  }

  /// Proper UPI validation regex
  void validateUpi(String value) {
    final trimmed = value.trim().toLowerCase();

    final regex = RegExp(r'^[a-z0-9.\-_]{2,256}@[a-z0-9]{2,64}$');

    final isValid = regex.hasMatch(trimmed);

    isUpiValid.value = isValid;

    if (isValid) {
      // ✅ Automatically select custom upi
      selectedPaymentMethod.value = 'custom_upi';
    } else {
      // ✅ Remove selection if invalid
      if (selectedPaymentMethod.value == 'custom_upi') {
        selectedPaymentMethod.value = '';
      }
    }
  }

  bool get isPaymentValid {
    // If no payment method selected
    if (selectedPaymentMethod.value.isEmpty) return false;

    // If user is paying using custom UPI
    if (selectedPaymentMethod.value == 'custom_upi') {
      return isUpiValid.value;
    }

    // All other methods are valid once selected
    return true;
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void showAddUpiDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: _buildAddUpiBottomSheet(context),
      ),
    );
  }

  Widget _buildAddUpiBottomSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add New UPI ID',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// UPI INPUT
          Obx(
            () => AppInput(
              hint: "Enter UPI Id",
              controller: upiIdController,
              state: hasUserTypedUpi.value
                  ? (isUpiValid.value
                        ? AppInputState.selected
                        : AppInputState.wrong)
                  : AppInputState.selected,
            ),
          ),

          const SizedBox(height: 20),

          /// PAYMENT INFO CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary500,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: AppColors.white100, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Pay with your registered bank account:",
                    style: AppTextStyles.body5Regular,
                  ),
                ),
                Icon(Icons.account_balance, color: AppColors.grey700, size: 20),
                const SizedBox(width: 4),
                Text("****9752", style: AppTextStyles.body5SemiBold),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// PAY BUTTON
          Obx(
            () => AppButton(
              title:
                  "Pay ₹${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
              variant: AppButtonVariant.fill,
              state: isUpiValid.value
                  ? AppButtonState.enabled
                  : AppButtonState.disabled,
              onPressed: isUpiValid.value ? processPayment : null,
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void processPayment() {
    if (!isPaymentValid) return;

    Get.toNamed(
      Routes.paymentProcessing,
      arguments: {'amount': amount, 'fundName': fundName},
    );
  }
}
