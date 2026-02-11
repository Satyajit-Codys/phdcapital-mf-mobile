import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';
import 'fund_details_controller.dart';

class FundDetailsScreen extends StatelessWidget {
  FundDetailsScreen({super.key});

  final controller = Get.put(FundDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ================= HEADER =================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _backButton(),
                          const SizedBox(height: 24),

                          SvgPicture.asset(
                            "assets/icons/axis_icon.svg",
                            height: 42,
                            width: 48,
                          ),
                          const SizedBox(height: 12),

                          Text(
                            "Axis Blue-chip Fund",
                            style: AppTextStyles.h3SemiBold,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Axis Mutual Funds",
                            style: AppTextStyles.body4Regular.copyWith(
                              color: AppColors.grey400,
                            ),
                          ),
                          const SizedBox(height: 12),

                          Text(
                            "NAV",
                            style: AppTextStyles.body5Regular.copyWith(
                              color: AppColors.grey400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text("₹42.85", style: AppTextStyles.h3SemiBold),
                          const SizedBox(height: 4),
                          Text(
                            "As of 25 Sep",
                            style: AppTextStyles.body5Regular.copyWith(
                              color: AppColors.grey400,
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            "Risk Level",
                            style: AppTextStyles.body3SemiBold,
                          ),
                          const SizedBox(height: 8),
                          _riskLevelBar(),
                          const SizedBox(height: 8),
                          Text(
                            "Expense Ratio: 0.62%",
                            style: AppTextStyles.body5Regular.copyWith(
                              color: AppColors.grey400,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ================= DIVIDER =================
                    Divider(height: 1, thickness: 4, color: AppColors.grey50),

                    /// ================= TOP HOLDINGS =================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Top Holdings",
                            style: AppTextStyles.body3SemiBold,
                          ),
                          const SizedBox(height: 12),
                          _holdingItem("Reliance", "9.2%", AppColors.orange500),
                          const SizedBox(height: 12),
                          _holdingItem("HDFC Bank", "8.5%", AppColors.red500),
                          const SizedBox(height: 12),
                          _holdingItem("Infosys", "7.1%", AppColors.primary500),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Divider(height: 1, thickness: 4, color: AppColors.grey50),

                    /// ================= TAX INFORMATION =================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: _taxInformationSection(),
                    ),

                    const SizedBox(height: 20),

                    Divider(height: 1, thickness: 4, color: AppColors.grey50),

                    /// ================= COMPARE FUNDS =================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Compare Funds",
                            style: AppTextStyles.body3SemiBold,
                          ),
                          SizedBox(
                            width: 120,
                            child: AppButton(
                              title: "Compare",
                              variant: AppButtonVariant.fill,
                              state: AppButtonState.enabled,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Divider(height: 1, thickness: 4, color: AppColors.grey50),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            /// ================= BOTTOM CTA =================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: AppButton(
                title: "Invest Now",
                variant: AppButtonVariant.fill,
                state: AppButtonState.enabled,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------

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

  Widget _riskLevelBar() {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.grey100,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.orange500,
              ),
            ),
          ),
          const Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }

  Widget _holdingItem(String name, String percentage, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                name[0],
                style: AppTextStyles.body4SemiBold.copyWith(color: iconColor),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: AppTextStyles.body4SemiBold)),
          Text(
            percentage,
            style: AppTextStyles.body4SemiBold.copyWith(
              color: AppColors.green500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _taxInformationSection() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: controller.toggleTaxInfo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tax Information", style: AppTextStyles.body3SemiBold),
                Icon(
                  controller.isTaxInfoExpanded.value
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.grey700,
                ),
              ],
            ),
          ),
          if (controller.isTaxInfoExpanded.value) ...[
            const SizedBox(height: 8),
            Text(
              "Long-term capital gains above ₹1L taxed at 10%.",
              style: AppTextStyles.body4Regular.copyWith(
                color: AppColors.grey400,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
