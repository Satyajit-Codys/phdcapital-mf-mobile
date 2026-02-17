import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../main_navigation/main_navigation_controller.dart';

class StepupSipRequestScreen extends StatelessWidget {
  const StepupSipRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get arguments: {currentAmount, newAmount, effectiveDate}
    final Map<String, dynamic> args =
        Get.arguments as Map<String, dynamic>? ?? {};
    final double currentAmount = args['currentAmount'] ?? 5000;
    final double newAmount = args['newAmount'] ?? 7000;
    final String effectiveDate = args['effectiveDate'] ?? '10 Mar 2026';

    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Scaffold(
        backgroundColor: AppColors.white100,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Step-up SIP', style: AppTextStyles.h3SemiBold),
                      const SizedBox(height: 8),
                      Text(
                        'Order ID SIP2026PAUSE  •  Effective $effectiveDate',
                        style: AppTextStyles.body5Regular.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Current SIP
                      Text(
                        'Current SIP',
                        style: AppTextStyles.body5Regular.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${currentAmount.toStringAsFixed(0)} / month',
                        style: AppTextStyles.h5SemiBold,
                      ),

                      const SizedBox(height: 24),

                      // New SIP Amount
                      Text(
                        'New SIP Amount',
                        style: AppTextStyles.body5Regular.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${newAmount.toStringAsFixed(0)} / month',
                        style: AppTextStyles.h3SemiBold.copyWith(
                          color: AppColors.primary500,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Effective from
                      Text(
                        'Effective from',
                        style: AppTextStyles.body5Regular.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(effectiveDate, style: AppTextStyles.h5SemiBold),

                      const SizedBox(height: 32),

                      // Status Section
                      Text('Status', style: AppTextStyles.h5SemiBold),
                      const SizedBox(height: 16),

                      _buildStatusTimeline(newAmount),
                    ],
                  ),
                ),
              ),

              // Bottom Buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
                child: Column(
                  children: [
                    AppButton(
                      title: 'Back to SIP Details',
                      onPressed: () {
                        // Navigate to home and switch to SIP tab (index 3)
                        Get.offAllNamed('/home');
                        // Use a slight delay to ensure navigation completes
                        Future.delayed(const Duration(milliseconds: 100), () {
                          final controller =
                              Get.find<MainNavigationController>();
                          controller.changeTab(3);
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        // Navigate to portfolio
                      },
                      child: Text(
                        'View Portfolio',
                        style: AppTextStyles.h6SemiBold.copyWith(
                          color: AppColors.grey600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(double newAmount) {
    return Column(
      children: [
        _buildStatusItem(
          title: 'Request Submitted',
          subtitle: '12 Feb 2026, 10:05 AM',
          isCompleted: true,
          showLine: true,
        ),
        _buildStatusItem(
          title: 'Processing by Fund House',
          subtitle: 'Will update before next debit date',
          isCompleted: true,
          showLine: true,
        ),
        _buildStatusItem(
          title: 'SIP Amount Increased',
          subtitle: 'Awaiting confirmation',
          isCompleted: false,
          showLine: true,
        ),
        _buildStatusItem(
          title: 'SIP amount is Successfully increased',
          subtitle:
              'Your SIP amount is successfully increased to ₹${newAmount.toStringAsFixed(0)}/month',
          isCompleted: false,
          showLine: false,
          isSuccess: true,
        ),
      ],
    );
  }

  Widget _buildStatusItem({
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool showLine,
    bool isSuccess = false,
  }) {
    Color iconColor;
    Color iconBgColor;
    Color textColor;

    if (isSuccess) {
      iconColor = AppColors.white100;
      iconBgColor = AppColors.green500;
      textColor = AppColors.green600;
    } else if (isCompleted) {
      iconColor = AppColors.white100;
      iconBgColor = AppColors.primary500;
      textColor = AppColors.black100;
    } else {
      iconColor = AppColors.white100;
      iconBgColor = AppColors.grey300;
      textColor = AppColors.grey400;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isCompleted || isSuccess ? Icons.check : Icons.circle,
                  color: iconColor,
                  size: isCompleted || isSuccess ? 18 : 8,
                ),
              ),
            ),
            if (showLine)
              Container(
                width: 2,
                height: 40,
                color: AppColors.grey200,
                margin: const EdgeInsets.symmetric(vertical: 4),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.h6SemiBold.copyWith(color: textColor),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextStyles.body5Regular.copyWith(
                  color: AppColors.grey400,
                ),
              ),
              if (showLine) const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
