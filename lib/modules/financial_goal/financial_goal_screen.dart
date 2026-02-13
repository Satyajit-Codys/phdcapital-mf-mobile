// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../app/routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';
import 'financial_goal_controller.dart';

class FinancialGoalScreen extends StatelessWidget {
  FinancialGoalScreen({super.key});

  final controller = Get.put(FinancialGoalController());

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
                      Text(
                        "Set Your Financial Goal",
                        style: AppTextStyles.h3SemiBold,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Tell us your goal and we'll help you invest smarter.",
                        style: AppTextStyles.body4Regular.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// ================= SELECT GOAL TYPE =================
                      Text(
                        "Select Goal Type",
                        style: AppTextStyles.body4SemiBold,
                      ),

                      const SizedBox(height: 12),

                      Obx(
                        () => Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: controller.goals.map((goal) {
                            final isSelected =
                                controller.selectedGoal.value == goal['title'];
                            return _goalCard(
                              title: goal['title']!,
                              icon: goal['icon']!,
                              isSelected: isSelected,
                              onTap: () =>
                                  controller.selectGoal(goal['title']!),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// ================= TARGET AMOUNT =================
                      Text("Target Amount", style: AppTextStyles.body4SemiBold),
                      const SizedBox(height: 8),
                      TextField(
                        controller: controller.targetAmountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: AppTextStyles.body3SemiBold,
                        decoration: InputDecoration(
                          prefixText: "₹",
                          prefixStyle: AppTextStyles.body3SemiBold,
                          hintText: "10,00,000",
                          hintStyle: AppTextStyles.body3Regular.copyWith(
                            color: AppColors.grey300,
                          ),
                          filled: true,
                          fillColor: AppColors.grey50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        onChanged: (value) {
                          // Format with commas
                          if (value.isNotEmpty) {
                            final number = int.tryParse(
                              value.replaceAll(',', ''),
                            );
                            if (number != null) {
                              final formatted = number
                                  .toString()
                                  .replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]},',
                                  );
                              if (formatted != value) {
                                controller.targetAmountController.value =
                                    TextEditingValue(
                                      text: formatted,
                                      selection: TextSelection.collapsed(
                                        offset: formatted.length,
                                      ),
                                    );
                              }
                            }
                          }
                        },
                      ),

                      const SizedBox(height: 24),

                      /// ================= TIME HORIZON =================
                      Text("Time Horizon", style: AppTextStyles.body4SemiBold),
                      const SizedBox(height: 8),
                      Obx(
                        () => Column(
                          children: [
                            SliderTheme(
                              data: SliderThemeData(
                                activeTrackColor: AppColors.primary500,
                                inactiveTrackColor: AppColors.grey200,
                                thumbColor: AppColors.primary500,
                                overlayColor: AppColors.primary500.withOpacity(
                                  0.2,
                                ),
                                trackHeight: 4,
                              ),
                              child: Slider(
                                value: controller.timeHorizon.value,
                                min: 1,
                                max: 30,
                                divisions: 29,
                                onChanged: controller.updateTimeHorizon,
                              ),
                            ),
                            Text(
                              "Goal Duration: ${controller.timeHorizon.value.toInt()} Years",
                              style: AppTextStyles.body5Regular.copyWith(
                                color: AppColors.grey600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// ================= ESTIMATED SIP =================
                      Obx(
                        () => ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.green100,
                                    width: 1,
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.green500,
                                      AppColors.green500.withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Estimated Monthly SIP",
                                      style: AppTextStyles.body5Regular
                                          .copyWith(
                                            color: AppColors.white100
                                                .withOpacity(0.9),
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "₹${controller.estimatedSip.value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}/ month",
                                      style: AppTextStyles.h2SemiBold.copyWith(
                                        color: AppColors.white100,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      "Based on your goal amount and time horizon. Actual Returns may vary",
                                      style: AppTextStyles.caption2.copyWith(
                                        color: AppColors.white100.withOpacity(
                                          0.8,
                                        ),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: -22,
                                right: -10,
                                child: Image.asset(
                                  'assets/images/estimated_sip_img.png',
                                  width: 80,
                                  height: 100,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                  title: "Continue to Fund Recommendations",
                  variant: AppButtonVariant.fill,
                  state: controller.canProceed
                      ? AppButtonState.enabled
                      : AppButtonState.disabled,
                  onPressed: controller.canProceed
                      ? () {
                          Get.offAllNamed(Routes.allMutualFunds);
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

  Widget _goalCard({
    required String title,
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: (Get.width - 52) / 2,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary50 : AppColors.white100,
          border: Border.all(
            color: isSelected ? AppColors.primary500 : AppColors.grey100,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SvgPicture.asset("assets/icons/$icon.svg", height: 40, width: 40),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyles.body5SemiBold.copyWith(
                color: isSelected ? AppColors.primary500 : AppColors.grey900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
