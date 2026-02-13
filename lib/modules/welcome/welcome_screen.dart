import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_button_enum.dart';
import 'package:phdcapital_mf_mobile/widgets/app_button.dart';
import 'package:phdcapital_mf_mobile/widgets/app_checkbox.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_checkbox_enum.dart';
import 'welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final WelcomeController controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    // Set status bar to transparent with dark icons

    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topImage(),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title(),
                    const SizedBox(height: 5),
                    _subtitle(),
                    const SizedBox(height: 20),
                    _points(),
                    const SizedBox(height: 20),
                    _termsCheckbox(),
                    const SizedBox(height: 24),
                    _loginButton(),
                    const SizedBox(height: 16),
                    _exploreText(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // TOP IMAGE
  // --------------------------------------------------

  Widget _topImage() {
    return SizedBox(
      height: 420,
      width: double.infinity,
      child: Image.asset("assets/images/welcome_1.png", fit: BoxFit.cover),
    );
  }

  // --------------------------------------------------
  // TITLE
  // --------------------------------------------------

  Widget _title() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: "Invest with ", style: AppTextStyles.h3Medium),
          TextSpan(
            text: "Confidence",
            style: AppTextStyles.h3SemiBold.copyWith(
              color: AppColors.primary500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _subtitle() {
    return Text(
      "Smart mutual funds to grow your wealth steadily",
      style: AppTextStyles.subtitle,
    );
  }

  // --------------------------------------------------
  // BULLET POINTS
  // --------------------------------------------------

  Widget _points() {
    final points = [
      "Start investing with as little as ₹500",
      "Secure & SEBI-compliant funds",
      "Track returns anytime, anywhere",
    ];

    return Column(
      children: points
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    height: 22,
                    width: 22,
                    decoration: const BoxDecoration(
                      color: AppColors.primary500,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 14,
                      color: AppColors.white100,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(e, style: AppTextStyles.body4Regular)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  // --------------------------------------------------
  // TERMS CHECKBOX
  // --------------------------------------------------

  Widget _termsCheckbox() {
    return Obx(
      () => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.toggleAgreement(),
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
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "I understand that mutual fund investments are subject to market risks and I have read and agree to the Terms & Conditions.",
                style: AppTextStyles.body5Regular,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // LOGIN BUTTON
  // --------------------------------------------------

  Widget _loginButton() {
    return Obx(
      () => AppButton(
        title: "Login",
        state: controller.agreedToTerms.value
            ? AppButtonState.enabled
            : AppButtonState.disabled,
        onPressed: controller.agreedToTerms.value
            ? () {
                Get.toNamed("/login");
              }
            : null,
      ),
    );
  }

  // --------------------------------------------------
  // EXPLORE
  // --------------------------------------------------

  Widget _exploreText() {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Explore without login
          Get.toNamed("/home");
        },
        child: Text(
          "Explore without login",
          style: AppTextStyles.body3SemiBold,
        ),
      ),
    );
  }
}
