import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_radii.dart';
import 'sip_controller.dart';

class SipScreen extends StatelessWidget {
  SipScreen({super.key});

  final controller = Get.put(SipController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text('Your SIPs', style: AppTextStyles.h2SemiBold),
                  const SizedBox(height: 8),
                  Text(
                    'Track and manage your active systematic investment',
                    style: AppTextStyles.body4Regular.copyWith(
                      color: AppColors.grey400,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Active SIPs Section
                  ...controller.activeSips.map((sip) => _buildSipCard(sip)),

                  const SizedBox(height: 24),

                  // Recent Transactions Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Transaction',
                        style: AppTextStyles.h5SemiBold,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to all transactions
                        },
                        child: Text(
                          'View All Transaction',
                          style: AppTextStyles.body5Regular.copyWith(
                            color: AppColors.primary500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...controller.recentTransactions.map(
                    (txn) => _buildTransactionCard(txn),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSipCard(SipInvestment sip) {
    return InkWell(
      onTap: () => Get.toNamed('/sip-details', arguments: sip),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary50.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadii.medium),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/icons/axis_icon.svg"),
                const SizedBox(width: 12),

                // Fund Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sip.fundName, style: AppTextStyles.h5SemiBold),
                      const SizedBox(height: 4),
                      Text(
                        '₹${sip.amount.toStringAsFixed(0)} / month  •  Next debit: ${sip.nextDebitDate}',
                        style: AppTextStyles.caption2.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Status and View Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sip.status == SipStatus.active ? 'Active' : 'Paused',
                  style: AppTextStyles.body5SemiBold.copyWith(
                    color: sip.status == SipStatus.active
                        ? AppColors.green600
                        : AppColors.orange600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/sip-details', arguments: sip),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'View Details',
                        style: AppTextStyles.body5Regular.copyWith(
                          color: AppColors.primary500,
                        ),
                      ),
                      SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: SvgPicture.asset(
                          "assets/icons/arrow_right_icon.svg",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(SipTransaction txn) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Fund Icon
          SvgPicture.asset("assets/icons/axis_icon.svg"),
          const SizedBox(width: 12),

          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(txn.fundName, style: AppTextStyles.h6SemiBold),
                const SizedBox(height: 4),
                Text(
                  '₹${txn.amount.toStringAsFixed(0)} / month  •  ${txn.type}',
                  style: AppTextStyles.caption2.copyWith(
                    color: AppColors.grey400,
                  ),
                ),
              ],
            ),
          ),

          // Amount and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${txn.sipAmount.toStringAsFixed(0)}',
                style: AppTextStyles.h5SemiBold,
              ),
              const SizedBox(height: 4),
              Text(
                _getStatusText(txn.status),
                style: AppTextStyles.caption2.copyWith(
                  color: _getStatusColor(txn.status),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.complete:
        return 'Complete';
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.failed:
        return 'Failed';
    }
  }

  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.complete:
        return AppColors.green600;
      case TransactionStatus.pending:
        return AppColors.orange600;
      case TransactionStatus.failed:
        return AppColors.red600;
    }
  }
}
