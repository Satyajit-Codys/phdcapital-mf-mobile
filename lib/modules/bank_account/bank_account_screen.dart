import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_input_enum.dart';
import 'package:phdcapital_mf_mobile/widgets/app_switch.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_input.dart';
import '../../widgets/app_button.dart';
import '../../widgets/personal_details/step_indicator.dart';
import 'bank_account_controller.dart';

class BankAccountDetailsScreen extends StatelessWidget {
  BankAccountDetailsScreen({super.key});

  final controller = Get.put(BankAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      resizeToAvoidBottomInset: true,

      // 🔽 FIXED CTA
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
                    Get.toNamed(
                      "/bank-verification",
                      arguments: {
                        "bankName": controller.bankNameController.text.trim(),
                        "accountHolder": controller.accountHolderController.text
                            .trim(),
                        "accountNumber": controller.accountNumberController.text
                            .trim(),
                        "ifsc": controller.ifscController.text.trim(),
                      },
                    );
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
                "Step 5 of 6 · Bank Account Details",
                style: AppTextStyles.body5Regular,
              ),

              const SizedBox(height: 12),
              StepIndicator(current: 5, total: 6),

              const SizedBox(height: 24),
              Text("Bank Account Details", style: AppTextStyles.h3SemiBold),
              const SizedBox(height: 6),
              Text(
                "Add your bank account to receive returns & withdrawals",
                style: AppTextStyles.body4Regular,
              ),

              const SizedBox(height: 24),

              // Account holder
              AppInput(
                label: "Account holder Name",
                hint: "Enter name as per bank",
                controller: controller.accountHolderController,
              ),

              const SizedBox(height: 16),

              // Account number
              Obx(
                () => AppInput(
                  label: "Bank Account Number",
                  hint: "Enter account number",
                  controller: controller.accountNumberController,
                  keyboardType: TextInputType.number,
                  state: controller.isAccountNumberValid.value
                      ? AppInputState.normal
                      : AppInputState.wrong,
                ),
              ),

              Obx(
                () => !controller.isAccountNumberValid.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "Enter a valid account number (9–18 digits)",
                          style: AppTextStyles.body5Regular.copyWith(
                            color: AppColors.red500,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 16),

              // Re-enter account number
              Obx(
                () => AppInput(
                  label: "Re-enter Account Number",
                  hint: "Re-enter account number",
                  controller: controller.reAccountNumberController,
                  keyboardType: TextInputType.number,
                  state: controller.isAccountMatch.value
                      ? AppInputState.normal
                      : AppInputState.wrong,
                ),
              ),

              Obx(
                () =>
                    (!controller.isAccountMatch.value &&
                        controller.reAccountNumberController.text.isNotEmpty)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "Account numbers do not match",
                          style: AppTextStyles.body5Regular.copyWith(
                            color: AppColors.red500,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 16),

              // IFSC
              Obx(
                () => AppInput(
                  label: "IFSC Code",
                  hint: "Enter IFSC code",
                  controller: controller.ifscController,
                  state: controller.isIfscValid.value
                      ? AppInputState.normal
                      : AppInputState.wrong,
                ),
              ),

              Obx(
                () => !controller.isIfscValid.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "Enter a valid IFSC code",
                          style: AppTextStyles.body5Regular.copyWith(
                            color: AppColors.red500,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 16),

              // Bank name (auto-filled / read-only)
              AppInput(
                label: "Bank Name",
                hint: "Bank name",
                controller: controller.bankNameController,
                readOnly: true,
                state: AppInputState.normal,
              ),

              const SizedBox(height: 24),

              // Primary toggle
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Set as primary bank account",
                          style: AppTextStyles.body3SemiBold,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Primary account will be used for all payments",
                          style: AppTextStyles.body5Regular,
                        ),
                      ],
                    ),
                    AppSwitch(
                      value: controller.isPrimary.value,
                      onChanged: (v) => controller.isPrimary.value = v,
                    ),
                  ],
                ),
              ),

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
