import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../core/enums/app_checkbox_enum.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_checkbox.dart';
import 'terms_consent_controller.dart';

class TermsConsentScreen extends StatelessWidget {
  TermsConsentScreen({super.key});

  final controller = Get.put(TermsConsentController());

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
                      /// ================= BACK BUTTON =================
                      InkWell(
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

                      const SizedBox(height: 24),

                      /// ================= TITLE =================
                      Text("Terms & Consent", style: AppTextStyles.h3SemiBold),
                      const SizedBox(height: 8),
                      Text(
                        "Please review and accept before continuing",
                        style: AppTextStyles.body4Regular.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// ================= TERMS SECTIONS =================
                      _termSection(
                        number: "1",
                        title: "General",
                        description:
                            "By accessing and using this application, you agree to comply with all applicable laws and regulations related to mutual fund investments.",
                      ),

                      const SizedBox(height: 16),

                      _termSection(
                        number: "2",
                        title: "Investment Risk Disclosure",
                        description:
                            "Mutual fund investments are subject to market risks. Please read all scheme-related documents carefully before investing.",
                      ),

                      const SizedBox(height: 16),

                      _termSection(
                        number: "3",
                        title: "User Responsibility",
                        description:
                            "You are solely responsible for evaluating the suitability, risks, and returns of any investment made through this platform.",
                      ),

                      const SizedBox(height: 16),

                      _termSection(
                        number: "4",
                        title: "Data & Privacy",
                        description:
                            "Your personal and financial information is collected and stored securely in accordance with our Privacy Policy.",
                      ),

                      const SizedBox(height: 16),

                      _termSection(
                        number: "5",
                        title: "Regulatory Compliance",
                        description:
                            "All mutual fund schemes available on this app are offered through SEBI-registered asset management companies and partners.",
                      ),

                      const SizedBox(height: 24),

                      /// ================= PRIVACY POLICY LINK =================
                      InkWell(
                        onTap: () {
                          // Navigate to privacy policy
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey100),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Privacy Policy",
                                style: AppTextStyles.body4Regular.copyWith(
                                  color: AppColors.primary500,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: AppColors.primary500,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// ================= CHECKBOX =================
                      Obx(
                        () => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: controller.toggleAgreement,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppCheckbox(
                                value: controller.agreedToTerms.value,
                                state: controller.agreedToTerms.value
                                    ? AppCheckboxState.checked
                                    : AppCheckboxState.unchecked,
                                onChanged: (_) => controller.toggleAgreement(),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "I understand that mutual fund investments are subject to market risks and I have read and agree to the Terms & Conditions.",
                                  style: AppTextStyles.body5Regular.copyWith(
                                    color: AppColors.grey700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            /// ================= BOTTOM BUTTON =================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Obx(
                () => AppButton(
                  title: "Agree & Continue",
                  variant: AppButtonVariant.fill,
                  state: controller.canProceed
                      ? AppButtonState.enabled
                      : AppButtonState.disabled,
                  onPressed: controller.canProceed
                      ? () {
                          Get.offAllNamed(Routes.home);
                        }
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _termSection({
    required String number,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$number. $title", style: AppTextStyles.body3SemiBold),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTextStyles.body5Regular.copyWith(
              color: AppColors.grey600,
            ),
          ),
        ],
      ),
    );
  }
}
