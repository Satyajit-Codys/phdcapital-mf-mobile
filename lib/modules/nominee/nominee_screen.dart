import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_input_enum.dart';
import 'package:phdcapital_mf_mobile/widgets/app_checkbox.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_input.dart';
import '../../widgets/app_dropdown.dart';
import '../../widgets/app_button.dart';
import '../../widgets/personal_details/step_indicator.dart';
import 'nominee_controller.dart';

class NomineeScreen extends StatelessWidget {
  NomineeScreen({super.key});

  final controller = Get.put(NomineeController());

  final relationships = const [
    "Spouse",
    "Father",
    "Mother",
    "Son",
    "Daughter",
    "Brother",
    "Sister",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      resizeToAvoidBottomInset: true,

      bottomNavigationBar: Obx(
        () => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
            top: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ---------------- SAVE NOMINEE ----------------
              AppButton(
                title: "Save Nominee (${controller.nominees.length + 1}/10)",
                variant: AppButtonVariant.fill,
                state:
                    controller.isFormValid.value &&
                        controller.canAddMoreNominees
                    ? AppButtonState.enabled
                    : AppButtonState.disabled,
                onPressed:
                    controller.isFormValid.value &&
                        controller.canAddMoreNominees
                    ? controller.saveNominee
                    : null,
              ),

              const SizedBox(height: 12),

              // ---------------- CONTINUE ----------------
              AppButton(
                title: "Continue",
                variant: AppButtonVariant.secondary,
                state: controller.hasAtLeastOneNominee
                    ? AppButtonState.enabled
                    : AppButtonState.disabled,
                onPressed: controller.hasAtLeastOneNominee
                    ? () {
                        if (!controller.isTotalShareValid) {
                          Get.snackbar(
                            "Share mismatch",
                            "Total nominee share must be exactly 100%",
                            backgroundColor: AppColors.red700.withOpacity(0.7),
                            colorText: AppColors.white100,
                            icon: const Icon(
                              Icons.error,
                              color: AppColors.red100,
                            ),
                          );
                          return;
                        }
                        Get.toNamed("/bank-account");
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
              const SizedBox(height: 16),

              Text(
                "Step 4 of 6 · Add Nominee",
                style: AppTextStyles.body5Regular,
              ),
              const SizedBox(height: 12),
              StepIndicator(current: 4, total: 6),

              const SizedBox(height: 24),
              Obx(() {
                if (controller.nominees.isEmpty) return const SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("Nominees", style: AppTextStyles.h3SemiBold),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.grey300),
                        color: AppColors.white100,
                      ),
                      child: Column(
                        children: controller.nominees.asMap().entries.map((
                          entry,
                        ) {
                          final index = entry.key;
                          final nominee = entry.value;

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 44,
                                      width: 44,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.grey100,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${nominee.share}%",
                                        style: AppTextStyles.body4SemiBold,
                                      ),
                                    ),

                                    const SizedBox(width: 16),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            nominee.name,
                                            style: AppTextStyles.body3SemiBold,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            nominee.relationship,
                                            style: AppTextStyles.body5Regular
                                                .copyWith(
                                                  color: AppColors.grey500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // ✅ SAFE AppButton usage
                                    SizedBox(
                                      height: 36,
                                      width: 60,
                                      child: AppButton(
                                        title: "Edit",
                                        variant: AppButtonVariant.text,
                                        onPressed: () =>
                                            controller.editNominee(index),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // DIVIDER (not after last item)
                              if (index != controller.nominees.length - 1)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: AppColors.grey200,
                                  ),
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }),
              Obx(
                () => Text(
                  controller.isEditing ? "Edit Nominee" : "Add Nominee",
                  style: AppTextStyles.h3SemiBold,
                ),
              ),

              const SizedBox(height: 6),
              Text(
                "Secure your investments by nominating someone you trust",
                style: AppTextStyles.body4Regular,
              ),

              const SizedBox(height: 24),

              // Nominee Name
              AppInput(
                label: "Nominee Full Name",
                hint: "Enter nominee's full name",
                controller: controller.nomineeNameController,
              ),

              const SizedBox(height: 16),

              // DOB
              AppInput(
                label: "Date of Birth",
                hint: "dd-mm-yyyy",
                controller: controller.dobController,
                readOnly: true,
                onTap: () async {
                  final now = DateTime.now();

                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(now.year - 18),
                    firstDate: DateTime(1900),
                    lastDate: now,
                  );

                  if (pickedDate != null) {
                    controller.setDob(pickedDate); // ✅ IMPORTANT
                  }
                },
                suffixIcon: SvgPicture.asset(
                  "assets/icons/calendar_icon.svg",
                  height: 18,
                  width: 18,
                ),
              ),

              const SizedBox(height: 16),

              // Relationship
              Text(
                "Relationship with Nominee",
                style: AppTextStyles.inputLabel,
              ),
              const SizedBox(height: 6),
              Obx(() {
                final value = controller.relationship.value;
                return AppDropdown<String>(
                  hint: "Select Relationship",
                  value: value,
                  values: relationships,
                  labelBuilder: (v) => v,
                  onChanged: (v) => controller.relationship.value = v,
                );
              }),

              const SizedBox(height: 16),

              // Share
              AppInput(
                label: "Nominee Share (%)",
                hint: "100",
                controller: controller.shareController,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 16),

              // ---------------- NOMINEE ADDRESS (OPTIONAL) ----------------
              Text(
                "Nominee Address (Optional)",
                style: AppTextStyles.inputLabel,
              ),

              AppInput(
                hint: "Address Line 1",
                controller: controller.nomineeAddressLine1Controller,
              ),

              AppInput(
                hint: "City, State, Pincode",
                controller: controller.nomineeAddressLine2Controller,
              ),

              const SizedBox(height: 20),

              // Guardian (Only if minor)
              Obx(() {
                if (!controller.isMinor.value) {
                  return const SizedBox.shrink();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Guardian Details (Required if nominee is a minor)",
                      style: AppTextStyles.body3SemiBold,
                    ),
                    const SizedBox(height: 16),

                    AppInput(
                      label: "Guardian Name",
                      hint: "Enter guardian's full name",
                      controller: controller.guardianNameController,
                    ),

                    const SizedBox(height: 16),

                    AppInput(
                      label: "Guardian PAN",
                      hint: "ABCDE1234F",
                      controller: controller.guardianPanController,
                      keyboardType: TextInputType.text,
                      state: controller.panText.value.isEmpty
                          ? AppInputState.normal
                          : controller.isPanValid.value
                          ? AppInputState.right
                          : AppInputState.wrong,
                    ),
                  ],
                );
              }),

              const SizedBox(height: 24),

              // Consent
              Obx(
                () => GestureDetector(
                  onTap: () => controller.consentChecked.value =
                      !controller.consentChecked.value,
                  child: Container(
                    padding: const EdgeInsets.all(0),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppCheckbox(
                          value: controller.consentChecked.value,
                          onChanged: (v) => controller.consentChecked.value = v,
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            "I confirm that the nominee details provided are correct and I understand that nomination helps in smooth transfer of investments.",
                            style: AppTextStyles.body5Regular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

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
