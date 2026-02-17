import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_icons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_button.dart';

class PauseSipRequestScreen extends StatelessWidget {
  const PauseSipRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Align(
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
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pause SIP Request', style: AppTextStyles.h3SemiBold),
                    const SizedBox(height: 8),
                    Text(
                      'Order ID SIP2026PAUSE  •  12 Feb 2026',
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Fund Info
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/axis_icon.svg",
                          height: 48,
                          width: 48,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Axis Bluechip Fund',
                              style: AppTextStyles.h5SemiBold,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Large Cap Equity',
                              style: AppTextStyles.body5Regular.copyWith(
                                color: AppColors.grey400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // SIP Amount
                    Text(
                      'SIP Amount',
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹5,000 / month',
                      style: AppTextStyles.h4SemiBold.copyWith(
                        color: AppColors.primary500,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Status Section
                    Text('Status', style: AppTextStyles.h5SemiBold),
                    const SizedBox(height: 16),

                    _buildStatusTimeline(),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Column(
                children: [
                  AppButton(
                    title: 'Back to SIP Details',
                    onPressed: () {
                      Get.back();
                      Get.back();
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
    );
  }

  Widget _buildStatusTimeline() {
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
          subtitle: 'Expected within 1 working day',
          isCompleted: true,
          showLine: true,
        ),
        _buildStatusItem(
          title: 'SIP Paused',
          subtitle: 'Waiting for confirmation',
          isCompleted: false,
          showLine: true,
        ),
        _buildStatusItem(
          title: 'SIP Paused Successfully',
          subtitle: 'No further auto-debits will happen until resumed.',
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
        // LEFT SIDE
        SizedBox(
          width: 22,
          child: Column(
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
                    size: isCompleted || isSuccess ? 10 : 8,
                  ),
                ),
              ),

              if (showLine)
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.grey200,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // RIGHT SIDE TEXT
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
