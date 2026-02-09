import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/widgets/app_button.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_radii.dart';
import 'language_controller.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final LanguageController controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 24),
              Expanded(child: _languageList()),
              _continueButton(),
              const SizedBox(height: 16),
              _skipButton(),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // HEADER
  // --------------------------------------------------

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Choose your language", style: AppTextStyles.h2SemiBold),
        const SizedBox(height: 6),
        Text(
          "You can change this later from settings",
          style: AppTextStyles.body4Regular,
        ),
      ],
    );
  }

  // --------------------------------------------------
  // LIST
  // --------------------------------------------------

  Widget _languageList() {
    return ListView.separated(
      itemCount: controller.languages.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = controller.languages[index];

        return Obx(() {
          final isSelected = controller.selectedIndex.value == index;

          return GestureDetector(
            onTap: () => controller.selectLanguage(index),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary50 : AppColors.white100,
                borderRadius: BorderRadius.circular(AppRadii.medium),
                border: Border.all(
                  color: isSelected ? AppColors.primary500 : AppColors.grey100,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["title"]!,
                          style: AppTextStyles.body3SemiBold,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item["subtitle"]!,
                          style: AppTextStyles.body5Regular,
                        ),
                      ],
                    ),
                  ),
                  _radio(isSelected),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  // --------------------------------------------------
  // RADIO INDICATOR
  // --------------------------------------------------

  Widget _radio(bool selected) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.primary500 : AppColors.grey100,
          width: 2,
        ),
      ),
      child: selected
          ? Center(
              child: Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary500,
                ),
              ),
            )
          : null,
    );
  }

  // --------------------------------------------------
  // CONTINUE BUTTON
  // --------------------------------------------------

  Widget _continueButton() {
    return AppButton(
      title: "Continue",
      onPressed: () {
        final index = controller.selectedIndex.value;
        final selected = controller.languages[index]["title"];
        debugPrint("Selected Language: $selected");

        // Navigate next screen
        Get.toNamed("/welcome");
      },
    );
  }

  // --------------------------------------------------
  // SKIP
  // --------------------------------------------------

  Widget _skipButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Skip logic
          Get.toNamed("/home");
        },
        child: Text("Skip", style: AppTextStyles.body3SemiBold),
      ),
    );
  }
}
