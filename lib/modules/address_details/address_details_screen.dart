import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_input_enum.dart';
import 'package:phdcapital_mf_mobile/widgets/app_switch.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_input.dart';
import '../../widgets/app_dropdown.dart';
import '../../widgets/app_button.dart';
import '../../widgets/personal_details/step_indicator.dart';
import '../../core/enums/app_button_enum.dart';
import 'address_details_controller.dart';

class AddressDetailsScreen extends StatelessWidget {
  AddressDetailsScreen({super.key});

  final controller = Get.put(AddressDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      resizeToAvoidBottomInset: true,

      // ✅ FIXED BOTTOM BUTTON
      bottomNavigationBar: Obx(
        () => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AppButton(
            title: "Continue",
            variant: AppButtonVariant.fill,
            state: controller.isFormValid.value
                ? AppButtonState.enabled
                : AppButtonState.disabled,
            onPressed: controller.isFormValid.value
                ? () {
                    // Go to Step 4
                    Get.toNamed("/nominee");
                  }
                : null,
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
              const SizedBox(height: 16),

              Text(
                "Step 3 of 5 · Address Details",
                style: AppTextStyles.body5Regular,
              ),

              const SizedBox(height: 12),
              StepIndicator(current: 3, total: 5),

              const SizedBox(height: 24),
              Text("Address Details", style: AppTextStyles.h3SemiBold),
              const SizedBox(height: 6),
              Text(
                "Enter your residential address for KYC verification",
                style: AppTextStyles.body4Regular,
              ),

              const SizedBox(height: 24),

              // ADDRESS LINE 1
              AppInput(
                label: "Address Line 1",
                hint: "House / Flat / Building name",
                controller: controller.addressLine1Controller,
              ),

              const SizedBox(height: 16),

              // ADDRESS LINE 2
              AppInput(
                label: "Address Line 2",
                hint: "Area / Street / Landmark (Optional)",
                controller: controller.addressLine2Controller,
              ),

              const SizedBox(height: 16),

              // STATE
              Text("State", style: AppTextStyles.inputLabel),
              const SizedBox(height: 6),
              Obx(() {
                final selectedState = controller.selectedState.value;

                return AppDropdown<String>(
                  hint: "Select State",
                  value: selectedState,
                  values: controller.states, // static list → OK
                  labelBuilder: (v) => v,
                  onChanged: controller.onStateSelected,
                );
              }),

              //CITY
              const SizedBox(height: 16),
              Text("City", style: AppTextStyles.inputLabel),
              const SizedBox(height: 6),
              Obx(() {
                final state = controller.selectedState.value;
                final city = controller.selectedCity.value;
                final cities = controller.cities; // recomputed in controller

                return AppDropdown<String>(
                  hint: "Select City",
                  value: city,
                  values: cities,
                  enabled: state != null,
                  labelBuilder: (v) => v,
                  onChanged: controller.onCitySelected,
                );
              }),

              const SizedBox(height: 16),

              // PINCODE
              Obx(() {
                final isValid = controller.isPincodeValid.value;
                final text = controller.pincodeController.text;

                return AppInput(
                  label: "Pincode",
                  hint: "Enter 6 digit pincode",
                  controller: controller.pincodeController,
                  keyboardType: TextInputType.number,
                  state: text.isEmpty
                      ? AppInputState.normal
                      : isValid
                      ? AppInputState.right
                      : AppInputState.wrong,
                );
              }),

              Obx(() {
                final isValid = controller.isPincodeValid.value;
                final text = controller.pincodeController.text;

                if (isValid || text.isEmpty) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "Enter a valid 6 digit pincode",
                    style: AppTextStyles.body5Regular.copyWith(
                      color: AppColors.red500,
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // SAME AS CURRENT ADDRESS
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Same as current address",
                          style: AppTextStyles.body3SemiBold,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Use this address for all communication",
                          style: AppTextStyles.body5Regular,
                        ),
                      ],
                    ),
                    // Switch(
                    //   value: controller.sameAsCurrent.value,
                    //   activeColor: AppColors.primary500,
                    //   onChanged: (v) => controller.sameAsCurrent.value = v,
                    // ),
                    AppSwitch(
                      value: controller.sameAsCurrent.value,
                      onChanged: (v) => controller.sameAsCurrent.value = v,
                    ),
                  ],
                ),
              ),

              // spacing so content isn't hidden by button
              const SizedBox(height: 30),
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
