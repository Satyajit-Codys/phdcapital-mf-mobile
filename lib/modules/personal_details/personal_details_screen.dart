import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_input_enum.dart';
import 'package:phdcapital_mf_mobile/widgets/app_dropdown.dart';
import 'package:phdcapital_mf_mobile/widgets/personal_details/step_indicator.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_input.dart';
import '../../core/enums/app_button_enum.dart';
import 'personal_details_controller.dart';

class PersonalDetailsScreen extends StatelessWidget {
  PersonalDetailsScreen({super.key});

  final controller = Get.put(PersonalDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _backButton(),
              const SizedBox(height: 16),
              Text(
                "Step 1 of 5 · Personal Information",
                style: AppTextStyles.body5Regular,
              ),
              const SizedBox(height: 12),
              StepIndicator(current: 1, total: 5),
              const SizedBox(height: 24),
              _header(),
              const SizedBox(height: 24),
              _form(context),
              const SizedBox(height: 32),
              _continueButton(),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // UI SECTIONS
  // --------------------------------------------------

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

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Personal Details", style: AppTextStyles.h3SemiBold),
        const SizedBox(height: 6),
        Text(
          "Tell us a bit about yourself to complete your profile",
          style: AppTextStyles.body4Regular,
        ),
      ],
    );
  }

  Widget _form(BuildContext context) {
    return Column(
      children: [
        AppInput(
          label: "Full Name",
          hint: "Enter your full name (as per PAN)",
          controller: controller.fullNameController,
        ),
        const SizedBox(height: 16),

        Obx(
          () => AppInput(
            label: "Email ID",
            hint: "Enter your email",
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            state: controller.isEmailValid.value
                ? AppInputState.normal
                : AppInputState.wrong,
          ),
        ),

        const SizedBox(height: 16),

        AppInput(
          label: "Date of Birth",
          hint: "dd-mm-yyyy",
          controller: controller.dobController,
          readOnly: true, // 👈 IMPORTANT
          onTap: () async {
            final now = DateTime.now();

            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(now.year - 18), // sensible default
              firstDate: DateTime(1900),
              lastDate: now,
            );

            if (pickedDate != null) {
              final formatted =
                  "${pickedDate.day.toString().padLeft(2, '0')}-"
                  "${pickedDate.month.toString().padLeft(2, '0')}-"
                  "${pickedDate.year}";

              controller.dobController.text = formatted;
              controller.validateForm();
            }
          },
          suffixIcon: SvgPicture.asset(
            "assets/icons/calendar_icon.svg",
            height: 18,
            width: 18,
          ),
        ),

        const SizedBox(height: 16),

        // ---------------- GENDER ----------------
        Obx(
          () => AppDropdown<String>(
            hint: "Select Gender",
            value: controller.gender.value,
            values: const ["Male", "Female", "Other"],
            labelBuilder: (v) => v,
            onChanged: (v) => controller.gender.value = v,
          ),
        ),

        const SizedBox(height: 16),

        // ---------------- MARITAL STATUS ----------------
        Obx(
          () => AppDropdown<String>(
            hint: "Marital Status",
            value: controller.maritalStatus.value,
            values: const ["Unmarried", "Married", "Divorced", "Widowed"],
            labelBuilder: (v) => v,
            onChanged: (v) => controller.maritalStatus.value = v,
          ),
        ),

        const SizedBox(height: 16),

        // ---------------- OCCUPATION ----------------
        Obx(
          () => AppDropdown<String>(
            hint: "Occupation",
            value: controller.occupation.value,
            values: const [
              "Salaried",
              "Self Employed",
              "Business",
              "Student",
              "Retired",
            ],
            labelBuilder: (v) => v,
            onChanged: (v) => controller.occupation.value = v,
          ),
        ),

        const SizedBox(height: 16),

        // ---------------- INCOME RANGE ----------------
        Obx(
          () => AppDropdown<String>(
            hint: "Income Range",
            value: controller.incomeRange.value,
            values: const [
              "Below ₹5 Lakhs",
              "₹5 – ₹10 Lakhs",
              "₹10 – ₹25 Lakhs",
              "Above ₹25 Lakhs",
            ],
            labelBuilder: (v) => v,
            onChanged: (v) => controller.incomeRange.value = v,
          ),
        ),
      ],
    );
  }

  Widget _continueButton() {
    return Obx(
      () => AppButton(
        title: "Continue",
        variant: AppButtonVariant.fill,
        state: controller.isFormValid.value
            ? AppButtonState.enabled
            : AppButtonState.disabled,
        onPressed: controller.isFormValid.value
            ? () {
                // Go to Step 2
                Get.toNamed("/pan-verify");
              }
            : null,
      ),
    );
  }
}
