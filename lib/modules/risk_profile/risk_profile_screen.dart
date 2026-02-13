import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';

class RiskProfileScreen extends StatelessWidget {
  const RiskProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get risk profile from arguments or default to Moderate
    final riskProfile =
        Get.arguments?['riskProfile'] ?? 'Moderate Risk Investor';

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
                        "Your Risk Profile",
                        style: AppTextStyles.h3SemiBold,
                      ),

                      const SizedBox(height: 24),

                      /// ================= RISK CATEGORY CARD =================
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary500,
                                    AppColors.primary500.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Text(
                                    "Risk Category",
                                    style: AppTextStyles.body5Regular.copyWith(
                                      color: AppColors.white100.withOpacity(
                                        0.9,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    riskProfile,
                                    style: AppTextStyles.h2SemiBold.copyWith(
                                      color: AppColors.white100,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: -36,
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: Opacity(
                                opacity: 1,
                                child: Image.asset(
                                  'assets/images/risk_category_img.png',
                                  width: double.infinity,
                                  height: 100,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -30,
                              left: -30,
                              child: Opacity(
                                opacity: 0.4,
                                child: Image.asset(
                                  'assets/images/risk_category_img.png',
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// ================= DESCRIPTION =================
                      Text(
                        "Based on your answers, you are comfortable with some market fluctuations to achieve better long-term growth. Your investments can balance stability with reasonable returns.",
                        style: AppTextStyles.body4Regular.copyWith(
                          color: AppColors.grey600,
                        ),
                      ),

                      const SizedBox(height: 32),

                      /// ================= SUGGESTED FUND CATEGORIES =================
                      Text(
                        "Suggested Fund Categories",
                        style: AppTextStyles.body2SemiBold,
                      ),

                      const SizedBox(height: 16),

                      _fundCategory(
                        title: "Large Cap Equity Funds",
                        description:
                            "Stable companies with steady long-term growth.",
                      ),

                      const SizedBox(height: 16),

                      _fundCategory(
                        title: "Hybrid / Balanced Funds",
                        description:
                            "Combination of equity and debt for reduced volatility.",
                      ),

                      const SizedBox(height: 16),

                      _fundCategory(
                        title: "Index Funds",
                        description:
                            "Market-linked returns with lower expense ratios.",
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// ================= BOTTOM SECTION =================
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AppButton(
                    title: "Set Your Financial Goal",
                    variant: AppButtonVariant.fill,
                    state: AppButtonState.enabled,
                    onPressed: () {
                      Get.toNamed(Routes.financialGoal);
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "You can update you risk profile anytime from settings",
                    style: AppTextStyles.body5Regular.copyWith(
                      color: AppColors.grey400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fundCategory({required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.body3SemiBold),
        const SizedBox(height: 4),
        Text(
          description,
          style: AppTextStyles.body5Regular.copyWith(color: AppColors.grey400),
        ),
      ],
    );
  }
}
