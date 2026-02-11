import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/modules/aadhaar_ekyc/aadhaar_ekyc_controller.dart';
import 'package:phdcapital_mf_mobile/widgets/app_checkbox.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../core/enums/app_input_enum.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_input.dart';

class AadhaarEkycScreen extends StatelessWidget {
  AadhaarEkycScreen({super.key});

  final controller = Get.put(AadhaarEkycController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,

      // 🔽 FIXED CTA
      bottomNavigationBar: Obx(
        () => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
            top: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ CONSENT (just above CTA)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => controller.consentGiven.toggle(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppCheckbox(
                      value: controller.consentGiven.value,
                      onChanged: (v) => controller.consentGiven.value = v,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "I consent to receive an OTP on my Aadhaar-linked mobile number for identity verification.",
                        style: AppTextStyles.body5Regular,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ✅ CTA
              AppButton(
                title: "Send OTP",
                variant: AppButtonVariant.fill,
                state: controller.isFormValid.value
                    ? AppButtonState.enabled
                    : AppButtonState.disabled,
                onPressed: controller.isFormValid.value
                    ? () {
                        // Navigate to OTP screen
                        Get.toNamed("/aadhaar-otp");
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _backButton(),
              const SizedBox(height: 24),

              // ---------------- HEADER ----------------
              Text("Aadhaar eKYC", style: AppTextStyles.h3SemiBold),
              const SizedBox(height: 6),
              Text(
                "Verify your identity securely using Aadhaar OTP Authentication",
                style: AppTextStyles.body4Regular,
              ),

              const SizedBox(height: 24),

              // ---------------- AADHAAR INPUT ----------------
              Obx(
                () => AppInput(
                  label: "Aadhaar Number",
                  hint: "Enter 12-digit Aadhaar number",
                  controller: controller.aadhaarController,
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  state: controller.isAadhaarValid.value
                      ? AppInputState.selected
                      : AppInputState.wrong,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Your Aadhaar details are encrypted and never stored",
                style: AppTextStyles.body5Regular.copyWith(
                  color: AppColors.grey500,
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BACK BUTTON
  // ---------------------------------------------------------------------------
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
