// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';
import 'payment_controller.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final controller = Get.put(
    PaymentController(
      amount: Get.arguments?['amount'] ?? 5000,
      fundName: Get.arguments?['fundName'] ?? 'Axis Blue-chip Fund',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ================= HEADER =================
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.grey100),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "Complete Your Payment",
                            style: AppTextStyles.body2SemiBold,
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      /// ================= FUND INFO =================
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/axis_icon.svg",
                            height: 32,
                            width: 36,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              controller.fundName,
                              style: AppTextStyles.body3SemiBold,
                            ),
                          ),
                          Text(
                            "₹${controller.amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                            style: AppTextStyles.body2SemiBold.copyWith(
                              color: AppColors.green500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      /// ================= PAY USING =================
                      Text(
                        "Pay using",
                        style: AppTextStyles.body3SemiBold.copyWith(
                          color: AppColors.grey700,
                        ),
                      ),

                      const SizedBox(height: 24),

                      _paymentOption(
                        icon: "assets/icons/gpay_icon.svg",
                        label: "Google Pay",
                        value: "googlepay",
                        height: 24,
                        width: 24,
                      ),

                      const SizedBox(height: 24),

                      _paymentOption(
                        icon: "assets/icons/paytm_icon.svg",
                        label: "Paytm",
                        value: "paytm",
                        height: 24,
                        width: 24,
                      ),

                      const SizedBox(height: 24),

                      _paymentOption(
                        icon: "assets/icons/bhim_icon.svg",
                        label: "BHIM",
                        value: "bhim",
                        height: 24,
                        width: 24,
                      ),

                      const SizedBox(height: 24),

                      InkWell(
                        onTap: () => controller.showAddUpiDialog(context),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/add_icon.svg",
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Add New UPI ID",
                                style: AppTextStyles.body4Regular,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: AppColors.grey400,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      /// ================= NET BANKING =================
                      Text(
                        "Pay using Net Banking",
                        style: AppTextStyles.body3SemiBold.copyWith(
                          color: AppColors.grey700,
                        ),
                      ),

                      const SizedBox(height: 24),

                      _paymentOption(
                        icon: "assets/icons/netbanking_icon.svg",
                        label: "Net Banking",
                        value: "netbanking",
                        height: 24,
                        width: 24,
                      ),

                      const SizedBox(height: 32),

                      /// ================= BANK ACCOUNT INFO =================
                    ],
                  ),
                ),
              ),
            ),

            /// ================= BOTTOM CTA =================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: Column(
                children: [
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
                          child: Icon(
                            Icons.check,
                            color: AppColors.white100,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Pay with your registered bank account:",
                            style: AppTextStyles.body5Regular,
                          ),
                        ),
                        Icon(
                          Icons.account_balance,
                          color: AppColors.grey700,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text("****9752", style: AppTextStyles.body5SemiBold),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Obx(
                    () => AppButton(
                      title:
                          "Pay ₹${controller.amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      variant: AppButtonVariant.fill,
                      state: controller.isPaymentValid
                          ? AppButtonState.enabled
                          : AppButtonState.disabled,
                      onPressed: controller.isPaymentValid
                          ? controller.processPayment
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption({
    required String icon,
    required String label,
    required String value,
    required double height,
    required double width,
  }) {
    return Obx(
      () => InkWell(
        onTap: () => controller.selectPaymentMethod(value),
        child: Row(
          children: [
            SvgPicture.asset(icon, height: height, width: width),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: AppTextStyles.body4Regular)),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: controller.selectedPaymentMethod.value == value
                      ? AppColors.primary500
                      : AppColors.grey300,
                  width: 2,
                ),
              ),
              child: controller.selectedPaymentMethod.value == value
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary500,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
