import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';
import '../../widgets/personal_details/step_indicator.dart';
import 'risk_assessment_controller.dart';

class RiskAssessmentScreen extends StatelessWidget {
  RiskAssessmentScreen({super.key});

  final controller = Get.put(RiskAssessmentController());

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
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ================= BACK BUTTON =================
                        InkWell(
                          onTap: () {
                            if (controller.currentQuestion.value > 1) {
                              controller.previousQuestion();
                            } else {
                              Get.back();
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey100),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// ================= TITLE =================
                        Text(
                          "Risk Assessment",
                          style: AppTextStyles.h3SemiBold,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Help us understand your investment preferences.",
                          style: AppTextStyles.body4Regular.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// ================= PROGRESS =================
                        Text(
                          "Question ${controller.currentQuestion.value} of ${controller.totalQuestions}",
                          style: AppTextStyles.body5Regular.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        StepIndicator(
                          current: controller.currentQuestion.value,
                          total: controller.totalQuestions,
                        ),

                        const SizedBox(height: 32),

                        /// ================= QUESTION =================
                        Text(
                          controller.questions[controller
                                  .currentQuestion
                                  .value -
                              1]['question'],
                          style: AppTextStyles.body2SemiBold,
                        ),

                        const SizedBox(height: 24),

                        /// ================= OPTIONS =================
                        ...List.generate(
                          (controller.questions[controller
                                          .currentQuestion
                                          .value -
                                      1]['options']
                                  as List)
                              .length,
                          (index) {
                            final option =
                                (controller.questions[controller
                                            .currentQuestion
                                            .value -
                                        1]['options']
                                    as List)[index];
                            final isSelected =
                                controller.answers[controller
                                    .currentQuestion
                                    .value] ==
                                option['title'];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _optionCard(
                                title: option['title'],
                                subtitle: option['subtitle'],
                                isSelected: isSelected,
                                onTap: () {
                                  controller.selectAnswer(option['title']);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            /// ================= BOTTOM BUTTON =================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Obx(
                () => AppButton(
                  title: controller.buttonText,
                  variant: AppButtonVariant.fill,
                  state: controller.canProceed
                      ? AppButtonState.enabled
                      : AppButtonState.disabled,
                  onPressed: controller.canProceed
                      ? () {
                          if (controller.isLastQuestion) {
                            controller.submitAssessment();
                          } else {
                            controller.nextQuestion();
                          }
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

  Widget _optionCard({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary50 : AppColors.white100,
          border: Border.all(
            color: isSelected ? AppColors.primary500 : AppColors.grey100,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body3SemiBold.copyWith(
                      color: isSelected
                          ? AppColors.primary500
                          : AppColors.grey900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.body5Regular.copyWith(
                      color: AppColors.grey400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary500 : AppColors.grey300,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary500,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
