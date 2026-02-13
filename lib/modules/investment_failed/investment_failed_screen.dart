import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/app/routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class InvestmentFailedScreen extends StatelessWidget {
  const InvestmentFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar color to match header
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.red500,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.white100,
      body: Column(
        children: [
          /// ================= FAILED HEADER =================
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              32,
              MediaQuery.of(context).padding.top + 32,
              32,
              32,
            ),
            decoration: BoxDecoration(color: AppColors.red500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.white100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: AppColors.red500, size: 32),
                ),
                const SizedBox(height: 16),
                Text(
                  "Investment Failed",
                  style: AppTextStyles.h3SemiBold.copyWith(
                    color: AppColors.white100,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "We Couldn't complete your transaction this time.",
                  style: AppTextStyles.body4Regular.copyWith(
                    color: AppColors.white100.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "The payment was not completed by your bank.",
                      style: AppTextStyles.body4Regular,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "No amount has been deducted",
                      style: AppTextStyles.body3SemiBold,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "from your account.",
                      style: AppTextStyles.body4Regular.copyWith(
                        color: AppColors.grey700,
                      ),
                    ),
                    const SizedBox(height: 200),
                    Text(
                      "If any amount was debited, it will be automatically refunded to your bank account within 3-5 working days.",
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// ================= BOTTOM CTA =================
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.red500,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.offAllNamed(Routes.home);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            "Retry Investment",
                            style: AppTextStyles.body3SemiBold.copyWith(
                              color: AppColors.white100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Contact Support",
                    style: AppTextStyles.body3SemiBold.copyWith(
                      color: AppColors.grey700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
