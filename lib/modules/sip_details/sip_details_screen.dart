import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_icons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_radii.dart';
import '../../widgets/app_button.dart';
import '../sip/sip_controller.dart';
import 'sip_details_controller.dart';
import 'widgets/modify_sip_sheet.dart';
import 'widgets/pause_sip_sheet.dart';
import 'widgets/cancel_sip_sheet.dart';

class SipDetailsScreen extends StatelessWidget {
  SipDetailsScreen({super.key});

  final controller = Get.put(SipDetailsController());

  @override
  Widget build(BuildContext context) {
    // Check if arguments is a SipInvestment object
    final SipInvestment? sip = Get.arguments is SipInvestment
        ? Get.arguments as SipInvestment
        : null;

    // Handle null case or wrong type - navigate back if no SIP data
    if (sip == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
        Get.snackbar(
          'Error',
          'SIP data not found',
          backgroundColor: AppColors.red50,
          colorText: AppColors.red600,
        );
      });
      return const Scaffold(
        backgroundColor: AppColors.white100,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),

            /// 🔹 SCROLLABLE CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Fund Icon
                      SvgPicture.asset(
                        "assets/icons/axis_icon.svg",
                        height: 42,
                        width: 48,
                      ),

                      const SizedBox(height: 16),

                      Text(sip.fundName, style: AppTextStyles.h3SemiBold),
                      const SizedBox(height: 4),
                      Text(
                        'Large Cap Equity',
                        style: AppTextStyles.body4Regular.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Folio Number',
                        style: AppTextStyles.body5Regular.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('12345678', style: AppTextStyles.h5SemiBold),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SIP Amount',
                                style: AppTextStyles.body5Regular.copyWith(
                                  color: AppColors.grey400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹${sip.amount.toStringAsFixed(0)} / month',
                                style: AppTextStyles.h5SemiBold,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Next Debit Date',
                                style: AppTextStyles.body5Regular.copyWith(
                                  color: AppColors.grey400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${sip.nextDebitDate} 2026',
                                style: AppTextStyles.h5SemiBold,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      _buildInvestmentSummaryCard(),

                      const SizedBox(height: 8),

                      Text(
                        'Returns are calculated based on the latest available NAV',
                        style: AppTextStyles.body5Regular.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),

                      const SizedBox(height: 24),

                      _buildActionButtons(sip),

                      const SizedBox(height: 24),

                      // Extra spacing so content doesn't hide behind button
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔹 FIXED BOTTOM BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: AppButton(
                title: 'Modify SIP',
                onPressed: () => _showModifySipSheet(context, sip),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestmentSummaryCard() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary50.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadii.medium),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSummaryColumn(
              'Total Invested',
              '₹${controller.totalInvested.value.toStringAsFixed(0)}',
            ),
            _buildSummaryColumn(
              'Current Value',
              '₹${controller.currentValue.value.toStringAsFixed(0)}',
            ),
            _buildSummaryColumn(
              'Return',
              '+${controller.returnsPercentage.value.toStringAsFixed(2)}%',
              valueColor: AppColors.green600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryColumn(String label, String value, {Color? valueColor}) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.caption2.copyWith(color: AppColors.grey400),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.h5SemiBold.copyWith(
            color: valueColor ?? AppColors.black100,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(SipInvestment sip) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          icon: Icons.pause_circle_outline,
          label: 'Pause',
          onTap: () => _showPauseSipSheet(Get.context!),
        ),
        _buildActionButton(
          icon: Icons.currency_rupee,
          label: 'Redeem',
          onTap: () => Get.toNamed('/redeem-sip'),
        ),
        _buildActionButton(
          icon: Icons.trending_up,
          label: 'Step up',
          onTap: () => Get.toNamed('/stepup-sip', arguments: sip.amount),
        ),
        _buildActionButton(
          icon: Icons.swap_horiz,
          label: 'Switch',
          onTap: () => Get.toNamed('/switch-funds', arguments: sip.fundName),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.primary50,
              borderRadius: BorderRadius.circular(AppRadii.small),
            ),
            child: Center(
              child: Icon(icon, color: AppColors.primary500, size: 24),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.caption2.copyWith(color: AppColors.grey600),
          ),
        ],
      ),
    );
  }

  void _showModifySipSheet(BuildContext context, SipInvestment sip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ModifySipSheet(sip: sip),
    );
  }

  void _showPauseSipSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PauseSipSheet(),
    );
  }

  void _showCancelSipSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CancelSipSheet(),
    );
  }

  Widget _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// 🔹 CENTER TITLE
          Center(child: Text("SIP Details", style: AppTextStyles.h4SemiBold)),

          /// 🔹 LEFT BACK BUTTON
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: AppIcons.arrowLeftIcon(
                    size: 18,
                    color: AppColors.black100,
                  ),
                ),
              ),
            ),
          ),

          /// 🔹 RIGHT CANCEL BUTTON
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _showCancelSipSheet(context),
              child: Text(
                'Cancel SIP',
                style: AppTextStyles.body5SemiBold.copyWith(
                  color: AppColors.red500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
