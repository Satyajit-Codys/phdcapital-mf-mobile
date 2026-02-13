import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/widgets/app_switch.dart';
import 'package:phdcapital_mf_mobile/widgets/create_pin/pin_digit_field.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../core/enums/app_button_enum.dart';
import 'create_pin_controller.dart';

class CreatePinScreen extends StatelessWidget {
  CreatePinScreen({super.key});

  final controller = Get.put(CreatePinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _backButton(),
              const SizedBox(height: 24),
              Text("Secure Your App", style: AppTextStyles.h2SemiBold),
              const SizedBox(height: 6),
              Text(
                "Create a 4-digit PIN to protect your account",
                style: AppTextStyles.body4Regular,
              ),
              const SizedBox(height: 24),

              _pinSection(
                "Enter PIN",
                controller.pinControllers,
                controller.pinFocus,
              ),
              const SizedBox(height: 20),
              _pinSection(
                "Confirm PIN",
                controller.confirmControllers,
                controller.confirmFocus,
              ),

              const SizedBox(height: 20),
              _pinStrength(),
              const SizedBox(height: 20),
              _tips(),
              const SizedBox(height: 24),
              _toggles(),
              const SizedBox(height: 32),

              Obx(
                () => AppButton(
                  title: "Continue",
                  variant: AppButtonVariant.fill,
                  state: controller.isPinValid.value
                      ? AppButtonState.enabled
                      : AppButtonState.disabled,
                  onPressed: controller.isPinValid.value
                      ? () {
                          Get.toNamed("/terms-consent");
                        }
                      : null,
                ),
              ),
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

  Widget _pinSection(
    String title,
    List<TextEditingController> controllers,
    List<FocusNode> focusNodes,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.body4Regular),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (i) {
            return PinDigitField(
              obscure: true,
              height: 56,
              width: 70,
              controller: controllers[i],
              focusNode: focusNodes[i],
              previousFocus: i > 0 ? focusNodes[i - 1] : null,
              nextFocus: i < 3 ? focusNodes[i + 1] : null,
            );
          }),
        ),
      ],
    );
  }

  Widget _pinStrength() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("PIN Strength", style: AppTextStyles.body4Regular),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              3,
              (i) => Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 6),
                  height: 6,
                  decoration: BoxDecoration(
                    color: controller.pinStrength.value > i
                        ? AppColors.green400
                        : AppColors.grey200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tips() {
    final tips = [
      "Use 4 unique digits",
      "Avoid sequences like 1234 or 0000",
      "PIN will be used for login & transaction",
    ];

    return Column(
      children: tips
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 6,
                    color: AppColors.primary500,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(e, style: AppTextStyles.body5Regular)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _toggles() {
    return Column(
      children: [
        _toggleTile("Enable Fingerprints", controller.enableFingerprint),
        const SizedBox(height: 12),
        _toggleTile("Enable Face Lock", controller.enableFaceLock),
      ],
    );
  }

  Widget _toggleTile(String title, RxBool value) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.body4Regular),
            AppSwitch(value: value.value, onChanged: (v) => value.value = v),
          ],
        ),
      ),
    );
  }
}
