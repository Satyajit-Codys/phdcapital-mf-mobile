import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/widgets/create_pin/pin_digit_field.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';
import '../../core/constants/app_icons.dart';
import 'otp_controller.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            Expanded(child: _content()),
            _bottomButton(),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // APP BAR
  // --------------------------------------------------

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AppIcons.arrowLeftIcon(
                  size: 18,
                  color: AppColors.black100,
                ),
              ),
            ),
          ),
          const Spacer(),
          Text("OTP Verification", style: AppTextStyles.h4SemiBold),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // CONTENT
  // --------------------------------------------------

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            "We have sent a Verification code to",
            style: AppTextStyles.body4Regular,
          ),
          const SizedBox(height: 6),
          Obx(
            () => Text(
              controller.maskedContact,
              style: AppTextStyles.body3SemiBold.copyWith(
                color: AppColors.primary500,
              ),
            ),
          ),

          const SizedBox(height: 32),
          _otpFields(),
          const SizedBox(height: 24),
          _resendText(),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // OTP FIELDS
  // --------------------------------------------------

  Widget _otpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(controller.otpLength, (index) {
        return PinDigitField(
          height: 52,
          width: 48,
          controller: controller.controllers[index],
          focusNode: controller.focusNodes[index],
          previousFocus: index > 0 ? controller.focusNodes[index - 1] : null,
          nextFocus: index < controller.otpLength - 1
              ? controller.focusNodes[index + 1]
              : null,
          obscure: false, // OTP should be visible
        );
      }),
    );
  }

  // --------------------------------------------------
  // RESEND
  // --------------------------------------------------

  Widget _resendText() {
    return Obx(() {
      final seconds = controller.secondsRemaining.value;

      // TIMER RUNNING (NOT CLICKABLE)
      if (seconds > 0) {
        return RichText(
          text: TextSpan(
            style: AppTextStyles.body4Regular,
            children: [
              const TextSpan(text: "Didn’t get the OTP? "),
              TextSpan(
                text: "Resend OTP in ${seconds}s",
                style: AppTextStyles.subtitle,
              ),
            ],
          ),
        );
      }

      // TIMER FINISHED (ONLY "RESEND OTP" CLICKABLE)
      return RichText(
        text: TextSpan(
          style: AppTextStyles.body4Regular,
          children: [
            const TextSpan(text: "Didn’t get the OTP? "),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: GestureDetector(
                onTap: controller.resendOtp,
                child: Text(
                  "Resend OTP",
                  style: AppTextStyles.body4SemiBold.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // --------------------------------------------------
  // BOTTOM BUTTON
  // --------------------------------------------------

  Widget _bottomButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => AppButton(
          title: "Continue",
          variant: AppButtonVariant.fill,
          state: controller.isOtpComplete.value
              ? AppButtonState.enabled
              : AppButtonState.disabled,
          onPressed: controller.isOtpComplete.value
              ? () {
                  // Verify OTP
                  Get.toNamed("create-pin");
                }
              : null,
        ),
      ),
    );
  }
}
