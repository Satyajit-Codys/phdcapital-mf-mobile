import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/widgets/segmented_loader.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';
import '../../widgets/personal_details/step_indicator.dart';
import 'bank_verification_controller.dart';

class BankVerificationScreen extends StatelessWidget {
  BankVerificationScreen({super.key});

  final controller = Get.put(BankVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,

      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: AppButton(
            title: "Continue",
            variant: AppButtonVariant.fill,
            state: controller.status.value == BankVerificationStatus.success
                ? AppButtonState.enabled
                : AppButtonState.disabled,
            onPressed: controller.status.value == BankVerificationStatus.success
                ? () {
                    // Navigate to dashboard / next flow
                    Get.toNamed("/home");
                  }
                : null,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _backButton(),
              const SizedBox(height: 16),

              Text(
                "Step 6 of 6 · Bank Account Details",
                style: AppTextStyles.body5Regular,
              ),
              const SizedBox(height: 12),
              StepIndicator(current: 6, total: 6),

              const SizedBox(height: 24),
              Text("Bank Verification", style: AppTextStyles.h3SemiBold),
              const SizedBox(height: 6),
              Text(
                "We are verifying your bank account",
                style: AppTextStyles.body4Regular,
              ),

              const SizedBox(height: 24),

              // ---------------- SUMMARY ----------------
              _summary(),

              const SizedBox(height: 24),

              // ---------------- STATUS ----------------
              Obx(() {
                switch (controller.status.value) {
                  case BankVerificationStatus.inProgress:
                    return verificationCard(
                      bgColor: AppColors.orange50,
                      borderColor: AppColors.orange400,
                      icon: SegmentedLoader(
                        size: 30,
                        color: AppColors.orange500,
                      ),
                      title: "Verification in progress",
                      subtitle: "This may take up to 24 hours",
                    );

                  case BankVerificationStatus.success:
                    return verificationCard(
                      bgColor: AppColors.green50,
                      borderColor: AppColors.green500,
                      icon: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.green500,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: AppColors.white100,
                          size: 18,
                        ),
                      ),
                      title: "Verification Successful",
                      subtitle: "Your verification is successful",
                    );

                  case BankVerificationStatus.failed:
                    return verificationCard(
                      bgColor: AppColors.red50,
                      borderColor: AppColors.red500,
                      icon: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.red500,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.white100,
                          size: 18,
                        ),
                      ),
                      title: "Verification Failed",
                      subtitle: "Your verification has failed",
                    );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summary() {
    return Column(
      children: [
        _row("Bank Name", controller.bankName),
        _row("Account Holder", controller.accountHolder),
        _row("Account No", controller.accountNoMasked),
        _row("IFSC", controller.ifsc),
      ],
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body5Regular),
          Text(value, style: AppTextStyles.body3SemiBold),
        ],
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey100),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.arrow_back_ios_new, size: 18),
      ),
    );
  }
}

Widget verificationCard({
  required Color bgColor,
  required Color borderColor,
  required Widget icon,
  required String title,
  required String subtitle,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: borderColor, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.body3SemiBold),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTextStyles.subtitle),
            ],
          ),
        ),
      ],
    ),
  );
}
