// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../app/routes.dart';
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

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    Divider(height: 1, thickness: 2, color: AppColors.grey50),

                    /// ================= PERFORMANCE CHART =================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: _performanceChart(),
                    ),

                    const SizedBox(height: 20),

                    /// ================= DIVIDER =================
                    Divider(height: 1, thickness: 2, color: AppColors.grey50),

                    /// ================= RETURN CALCULATOR =================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: _returnCalculator(),
                    ),

                    const SizedBox(height: 20),

                    /// ================= DIVIDER =================
                    Divider(height: 1, thickness: 2, color: AppColors.grey50),

                    /// ================= TOP HOLDINGS =================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: controller.toggleTopHoldings,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Top Holdings",
                                    style: AppTextStyles.body3SemiBold,
                                  ),
                                  Icon(
                                    controller.isTopHoldingsExpanded.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: AppColors.grey700,
                                  ),
                                ],
                              ),
                            ),
                            if (controller.isTopHoldingsExpanded.value) ...[
                              const SizedBox(height: 12),
                              _holdingItem(
                                "Reliance",
                                "9.2%",
                                "assets/icons/reliance_logo_icon.svg",
                                32,
                                32,
                              ),
                              const SizedBox(height: 12),
                              _holdingItem(
                                "HDFC Bank",
                                "8.5%",
                                "assets/icons/hdfc_bank_logo.svg",
                                40,
                                40,
                              ),
                              const SizedBox(height: 12),
                              _holdingItem(
                                "Infosys",
                                "7.1%",
                                "assets/icons/infosys_logo.svg",
                                18,
                                18,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Divider(height: 1, thickness: 2, color: AppColors.grey50),

                    /// ================= TAX INFORMATION =================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: _taxInformationSection(),
                    ),

                    const SizedBox(height: 20),

                    Divider(height: 1, thickness: 2, color: AppColors.grey50),

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
                              onPressed: () {
                                Get.toNamed(Routes.compareFunds);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Divider(height: 1, thickness: 2, color: AppColors.grey50),

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
                onPressed: () {
                  Get.toNamed(Routes.sipInvest);
                },
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

  Widget _holdingItem(
    String name,
    String percentage,
    String icon,
    double height,
    double width,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Container(
          //   width: 32,
          //   height: 32,
          //   decoration: BoxDecoration(
          //     color: iconColor.withOpacity(0.2),
          //     borderRadius: BorderRadius.circular(6),
          //   ),
          //   child: Center(
          //     child: Text(
          //       name[0],
          //       style: AppTextStyles.body4SemiBold.copyWith(color: iconColor),
          //     ),
          //   ),
          // ),
          SvgPicture.asset(icon, height: height, width: width),
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
                Text(
                  "Expense ratio, exit load & tax",
                  style: AppTextStyles.body3SemiBold,
                ),
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
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• ", style: AppTextStyles.body4SemiBold),
                Text("Expense ratio:", style: AppTextStyles.body4SemiBold),
                Text("0.63%", style: AppTextStyles.body4Regular),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Inclusive of GST",
              style: AppTextStyles.body5Regular.copyWith(
                color: AppColors.grey400,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• ", style: AppTextStyles.body4SemiBold),
                Text("Exit Load", style: AppTextStyles.body4SemiBold),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "For units above 10% of the investment, exit load of 2% if redeemed within 365 days and 1% if redeemed after 365 days but on or before 730 days.",
              style: AppTextStyles.body5Regular.copyWith(
                color: AppColors.grey400,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• ", style: AppTextStyles.body4SemiBold),
                Text(
                  "Stamp duty on investment",
                  style: AppTextStyles.body4SemiBold,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "0.005% (from July 1st, 2020)",
              style: AppTextStyles.body5Regular.copyWith(
                color: AppColors.grey400,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• ", style: AppTextStyles.body4SemiBold),
                Text("Tax Implications", style: AppTextStyles.body4SemiBold),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "If you redeem within one year, returns are taxed at 20%. If you redeem after one year, returns exceeding Rs 1.25 lakh in a financial year are taxed at 12.5%.",
              style: AppTextStyles.body5Regular.copyWith(
                color: AppColors.grey400,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _performanceChart() {
    return Obx(() {
      final chartData = controller.currentChartData;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Returns and Change
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(chartData.returns, style: AppTextStyles.h2SemiBold),
              const SizedBox(width: 8),
              Text(
                "${controller.selectedPeriod.value} annualised",
                style: AppTextStyles.body4Regular.copyWith(
                  color: AppColors.grey400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "-0.36% 1D",
            style: AppTextStyles.body4Regular.copyWith(color: AppColors.red500),
          ),

          const SizedBox(height: 24),

          // Chart
          SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),

                minX: 0,
                maxX: (controller.chartSpots.length - 1).toDouble(),

                minY:
                    controller.chartSpots
                        .map((e) => e.y)
                        .reduce((a, b) => a < b ? a : b) *
                    0.98,

                maxY:
                    controller.chartSpots
                        .map((e) => e.y)
                        .reduce((a, b) => a > b ? a : b) *
                    1.02,

                /// ✅ ADD THIS BLOCK
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,

                  getTouchedSpotIndicator:
                      (LineChartBarData barData, List<int> spotIndexes) {
                        return spotIndexes.map((index) {
                          return TouchedSpotIndicatorData(
                            FlLine(color: AppColors.grey400, strokeWidth: 1),
                            FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 6,
                                  color: AppColors.primary500,
                                  strokeWidth: 2,
                                  strokeColor: AppColors.white100,
                                );
                              },
                            ),
                          );
                        }).toList();
                      },

                  touchTooltipData: LineTouchTooltipData(
                    tooltipRoundedRadius: 8,
                    tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    tooltipMargin: 8,
                    getTooltipColor: (_) => AppColors.grey800,

                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        final nav = spot.y.toStringAsFixed(2);

                        return LineTooltipItem(
                          "NAV: $nav\n13th Apr 2020",
                          AppTextStyles.body5Regular.copyWith(
                            color: AppColors.white100,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),

                /// Your Line
                lineBarsData: [
                  LineChartBarData(
                    spots: controller.chartSpots,
                    isCurved: true,
                    curveSmoothness: 0.25,
                    preventCurveOverShooting: true,
                    color: AppColors.primary500,
                    barWidth: 2.2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Time Period Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['1M', '6M', '1Y', '3Y', '5Y', 'ALL'].map((period) {
              final isSelected = controller.selectedPeriod.value == period;
              return GestureDetector(
                onTap: () => controller.selectPeriod(period),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary100
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    period,
                    style: AppTextStyles.body4SemiBold.copyWith(
                      color: isSelected
                          ? AppColors.primary500
                          : AppColors.grey700,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // Invested and Total Returns
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Invested",
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text("₹64,497", style: AppTextStyles.h4SemiBold),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Total returns",
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text("33.12%", style: AppTextStyles.h4SemiBold),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _returnCalculator() {
    return Obx(
      () => Column(
        children: [
          InkWell(
            onTap: controller.toggleCalculator,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Return Calculator", style: AppTextStyles.body3SemiBold),
                Icon(
                  controller.isCalculatorExpanded.value
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.grey700,
                ),
              ],
            ),
          ),
          if (controller.isCalculatorExpanded.value) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                // Investment Type Toggle
                Row(
                  children: [
                    SizedBox(
                      width: 95,
                      height: 38,
                      child: GestureDetector(
                        onTap: () =>
                            controller.selectInvestmentType('Monthly SIP'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                controller.investmentType.value == 'Monthly SIP'
                                ? AppColors.primary100
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              "Monthly SIP",
                              style: AppTextStyles.body5SemiBold.copyWith(
                                color:
                                    controller.investmentType.value ==
                                        'Monthly SIP'
                                    ? AppColors.primary500
                                    : AppColors.grey700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    SizedBox(
                      width: 95,
                      height: 38,
                      child: GestureDetector(
                        onTap: () => controller.selectInvestmentType('Onetime'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: controller.investmentType.value == 'Onetime'
                                ? AppColors.primary100
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              "Onetime",
                              style: AppTextStyles.body5SemiBold.copyWith(
                                color:
                                    controller.investmentType.value == 'Onetime'
                                    ? AppColors.primary500
                                    : AppColors.grey700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Amount Display
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "₹${controller.investmentAmount.value.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      style: AppTextStyles.h3SemiBold,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.investmentType.value == 'Monthly SIP'
                          ? "Per month"
                          : "One time",
                      style: AppTextStyles.body4Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Slider
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppColors.primary500,
                    inactiveTrackColor: AppColors.grey200,
                    thumbColor: AppColors.primary500,
                    overlayColor: AppColors.primary500.withOpacity(0.2),
                    trackHeight: 4,
                  ),
                  child: Slider(
                    value: controller.investmentAmount.value,
                    min: controller.minAmount,
                    max: controller.maxAmount,
                    onChanged: controller.updateInvestmentAmount,
                  ),
                ),

                const SizedBox(height: 24),

                // Duration Selection
                Row(
                  children: [
                    Text(
                      "Over the past",
                      style: AppTextStyles.body4Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                    const SizedBox(width: 12),
                    ...['1 year', '3 years', '5 years'].map((duration) {
                      final isSelected =
                          controller.investmentDuration.value == duration;
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: GestureDetector(
                          onTap: () => controller.selectDuration(duration),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary100
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              duration,
                              style: AppTextStyles.body5SemiBold.copyWith(
                                color: isSelected
                                    ? AppColors.primary500
                                    : AppColors.grey700,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),

                const SizedBox(height: 24),

                // Results
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.grey50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total investment of ₹${controller.totalInvestment.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                        style: AppTextStyles.body4Regular.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "Would have become ",
                            style: AppTextStyles.body3SemiBold,
                          ),
                          Text(
                            "₹${controller.estimatedReturns.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                            style: AppTextStyles.body3SemiBold,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(${controller.returnPercentage.toStringAsFixed(2)}%)",
                            style: AppTextStyles.body3SemiBold.copyWith(
                              color: AppColors.green500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
