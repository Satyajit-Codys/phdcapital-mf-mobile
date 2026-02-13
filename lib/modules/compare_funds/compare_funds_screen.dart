import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_searchable_dropdown.dart';
import 'compare_funds_controller.dart';

enum ComparisonType { neutral, higherIsBetter, lowerIsBetter }

class CompareFundsScreen extends StatelessWidget {
  CompareFundsScreen({super.key});

  final controller = Get.put(CompareFundsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _backButton(),
                    const SizedBox(height: 24),

                    Text("Compare Funds", style: AppTextStyles.h2SemiBold),
                    const SizedBox(height: 6),
                    Text(
                      "Compare performance, risk and costs before investing",
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Fund 1 Dropdown
                    Text("Funds 1", style: AppTextStyles.body4SemiBold),
                    const SizedBox(height: 8),
                    Obx(
                      () => AppSearchableDropdown<String>(
                        hint: "Select Fund",
                        value: controller.selectedFund1.value,
                        values: controller.availableFundsForDropdown1,
                        labelBuilder: (v) => v,
                        onChanged: controller.selectFund1,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Fund 2 Dropdown
                    Text("Funds 2", style: AppTextStyles.body4SemiBold),
                    const SizedBox(height: 8),
                    Obx(
                      () => AppSearchableDropdown<String>(
                        hint: "Select Fund",
                        value: controller.selectedFund2.value,
                        values: controller.availableFundsForDropdown2,
                        labelBuilder: (v) => v,
                        onChanged: controller.selectFund2,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Comparison Table
                    Obx(() {
                      if (controller.selectedFund1.value == null ||
                          controller.selectedFund2.value == null) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Text(
                              "Select both funds to compare",
                              style: AppTextStyles.body4Regular.copyWith(
                                color: AppColors.grey400,
                              ),
                            ),
                          ),
                        );
                      }

                      return _comparisonTable();
                    }),
                  ],
                ),
              ),
            ),

            // Bottom Button
            Obx(() {
              final canInvest =
                  controller.selectedFund1.value != null ||
                  controller.selectedFund2.value != null;

              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: AppButton(
                  title: "Invest in Selected Fund",
                  variant: AppButtonVariant.fill,
                  state: canInvest
                      ? AppButtonState.enabled
                      : AppButtonState.disabled,
                  onPressed: canInvest
                      ? () {
                          // TODO: Navigate to invest screen
                        }
                      : null,
                ),
              );
            }),
          ],
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

  Widget _comparisonTable() {
    final fund1Data = controller.getFundData(controller.selectedFund1.value!);
    final fund2Data = controller.getFundData(controller.selectedFund2.value!);

    return Column(
      children: [
        // Header Row
        Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              child: Center(
                child: Text(
                  _shortenName(controller.selectedFund1.value!),
                  style: AppTextStyles.body4SemiBold,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  _shortenName(controller.selectedFund2.value!),
                  style: AppTextStyles.body4SemiBold,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        _comparisonRow(
          "NAV",
          fund1Data['nav']!,
          fund2Data['nav']!,
          ComparisonType.neutral,
        ),
        _comparisonRow(
          "1Y Returns",
          fund1Data['1y']!,
          fund2Data['1y']!,
          ComparisonType.higherIsBetter,
        ),
        _comparisonRow(
          "3Y Returns",
          fund1Data['3y']!,
          fund2Data['3y']!,
          ComparisonType.higherIsBetter,
        ),
        _comparisonRow(
          "5Y Returns",
          fund1Data['5y']!,
          fund2Data['5y']!,
          ComparisonType.higherIsBetter,
        ),
        _comparisonRow(
          "Expense Ratio",
          fund1Data['expense']!,
          fund2Data['expense']!,
          ComparisonType.lowerIsBetter,
        ),
        _comparisonRowRisk(
          "Risk Level",
          fund1Data['risk']!,
          fund2Data['risk']!,
        ),
        _comparisonRow(
          "Fund Size",
          fund1Data['size']!,
          fund2Data['size']!,
          ComparisonType.higherIsBetter,
        ),
        _comparisonRow(
          "Exit Load",
          fund1Data['exit']!,
          fund2Data['exit']!,
          ComparisonType.lowerIsBetter,
        ),
        _comparisonRow(
          "Min Investment",
          fund1Data['min']!,
          fund2Data['min']!,
          ComparisonType.lowerIsBetter,
        ),
      ],
    );
  }

  Widget _comparisonRow(
    String label,
    String value1,
    String value2,
    ComparisonType type,
  ) {
    Color color1 = AppColors.black100;
    Color color2 = AppColors.black100;

    if (type != ComparisonType.neutral) {
      final comparison = _compareValues(value1, value2, type);
      if (comparison == 1) {
        color1 = AppColors.green500;
      } else if (comparison == -1) {
        color2 = AppColors.green500;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grey100, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.body4Regular.copyWith(
                color: AppColors.grey700,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                value1,
                style: AppTextStyles.body4SemiBold.copyWith(color: color1),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                value2,
                style: AppTextStyles.body4SemiBold.copyWith(color: color2),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _comparisonRowRisk(String label, String risk1, String risk2) {
    Color color1 = AppColors.black100;
    Color color2 = AppColors.black100;

    if (risk1 != risk2) {
      final riskLevels = ["Low", "Moderate", "High", "Very High"];
      final index1 = riskLevels.indexOf(risk1);
      final index2 = riskLevels.indexOf(risk2);

      if (index1 != -1 && index2 != -1) {
        if (index1 < index2) {
          color1 = AppColors.green500;
        } else {
          color2 = AppColors.green500;
        }
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grey100, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.body4Regular.copyWith(
                color: AppColors.grey700,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                risk1,
                style: AppTextStyles.body4SemiBold.copyWith(color: color1),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                risk2,
                style: AppTextStyles.body4SemiBold.copyWith(color: color2),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _compareValues(String value1, String value2, ComparisonType type) {
    double num1 = _extractNumber(value1);
    double num2 = _extractNumber(value2);

    if (num1 == num2) return 0;

    if (type == ComparisonType.higherIsBetter) {
      return num1 > num2 ? 1 : -1;
    } else {
      return num1 < num2 ? 1 : -1;
    }
  }

  double _extractNumber(String value) {
    String cleaned = value
        .replaceAll('₹', '')
        .replaceAll('%', '')
        .replaceAll(' Cr', '')
        .replaceAll(',', '')
        .replaceAll(' (1Y)', '')
        .trim();

    return double.tryParse(cleaned) ?? 0;
  }

  String _shortenName(String name) {
    // Shorten fund names for header
    if (name.contains("Axis")) return "Axis Bluechip";
    if (name.contains("SBI")) return "SBI Bluechip";
    if (name.contains("HDFC")) return "HDFC Bluechip";
    if (name.contains("ICICI")) return "ICICI Bluechip";
    return name.split(" ").take(2).join(" ");
  }
}
