import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_input_enum.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_input.dart';
import '../../core/enums/app_button_enum.dart';
import 'pan_verification_controller.dart';
import '../../widgets/personal_details/step_indicator.dart';

class PanVerificationScreen extends StatelessWidget {
  PanVerificationScreen({super.key});

  final controller = Get.put(PanVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white100,

      // ✅ FIXED BOTTOM BUTTON
      bottomNavigationBar: Obx(() {
        final isVerifying = controller.isVerifying.value;
        final isVerified = controller.isVerified.value;
        final isPanValid = controller.isPanValid.value;

        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AppButton(
            title: isVerifying
                ? "Verifying..."
                : isVerified
                ? "Continue"
                : "Verify PAN",
            variant: AppButtonVariant.fill,

            // 🔐 enable rules
            state: (isVerified || (isPanValid && !isVerifying))
                ? AppButtonState.enabled
                : AppButtonState.disabled,

            onPressed: () {
              if (isVerifying) return;

              if (isVerified) {
                Get.toNamed("/address-details");
                return;
              }

              if (isPanValid) {
                controller.verifyPan();
              }
            },
          ),
        );
      }),

      // ✅ SCROLLABLE BODY
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _backButton(),
              const SizedBox(height: 16),

              Text(
                "Step 2 of 6 · PAN Verification",
                style: AppTextStyles.body5Regular,
              ),

              const SizedBox(height: 12),
              StepIndicator(current: 2, total: 6),

              const SizedBox(height: 24),
              Text("PAN Verification", style: AppTextStyles.h3SemiBold),
              const SizedBox(height: 6),
              Text(
                "Verify your PAN to continue investing",
                style: AppTextStyles.body4Regular,
              ),

              const SizedBox(height: 24),

              AppInput(
                label: "PAN Holder Name",
                hint: "Enter your full name (as per PAN)",
                controller: controller.panHolderNameController,
              ),

              const SizedBox(height: 16),

              Obx(
                () => AppInput(
                  label: "PAN Number",
                  hint: "Enter your PAN (ABCDE1234F)",
                  controller: controller.panController,
                  state: controller.panText.value.isEmpty
                      ? AppInputState.normal
                      : controller.isPanValid.value
                      ? AppInputState.right
                      : AppInputState.wrong,
                ),
              ),

              const SizedBox(height: 6),
              Text(
                "As per Income Tax records",
                style: AppTextStyles.body5Regular,
              ),

              const SizedBox(height: 12),

              Obx(
                () => controller.isVerified.value
                    ? Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.green500,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Verified Successfully",
                            style: AppTextStyles.body4Regular.copyWith(
                              color: AppColors.green500,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),

              // 👇 Extra space so last field isn’t hidden by button
              const SizedBox(height: 120),
            ],
          ),
        ),
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
