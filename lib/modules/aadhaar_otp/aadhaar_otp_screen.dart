import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../core/enums/app_input_enum.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_input.dart';
import 'aadhaar_otp_controller.dart';

class AadhaarOtpScreen extends StatelessWidget {
  AadhaarOtpScreen({super.key});

  final controller = Get.put(AadhaarOtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,

      // 🔽 FIXED CTA
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: AppButton(
            title: "Verify Aadhaar",
            variant: AppButtonVariant.fill,
            state: controller.isFormValid.value
                ? AppButtonState.enabled
                : AppButtonState.disabled,
            onPressed: controller.isFormValid.value
                ? () {
                    Get.toNamed("/upload-documents");
                  }
                : null,
          ),
        ),
      ),

      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _backButton(),
                const SizedBox(height: 24),

                // ---------------- OTP INPUT ----------------
                Obx(
                  () => AppInput(
                    label: "Enter OTP",
                    hint: "6-digit OTP",
                    controller: controller.otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    state: controller.isOtpValid.value
                        ? AppInputState.selected
                        : AppInputState.wrong,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "OTP sent to your Aadhaar-linked mobile number.",
                  style: AppTextStyles.body5Regular.copyWith(
                    color: AppColors.grey500,
                  ),
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BACK BUTTON
  // ---------------------------------------------------------------------------
  Widget _backButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 🔙 Back button (left aligned)
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
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
          ),
        ),

        // 🏷 Center title
        Text(
          "OTP Verification",
          style: AppTextStyles.h3SemiBold,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
