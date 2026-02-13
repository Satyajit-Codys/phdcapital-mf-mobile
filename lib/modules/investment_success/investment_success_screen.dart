import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../app/routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class InvestmentSuccessScreen extends StatelessWidget {
  const InvestmentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar color to match header
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.green500,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final amount = Get.arguments?['amount'] ?? 10000;
    final fundName = Get.arguments?['fundName'] ?? 'Axis Blue-chip Fund';

    return Scaffold(
      backgroundColor: AppColors.white100,
      body: Column(
        children: [
          /// ================= SUCCESS HEADER =================
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              32,
              MediaQuery.of(context).padding.top + 32,
              32,
              32,
            ),
            decoration: BoxDecoration(color: AppColors.green500),
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
                  child: Icon(Icons.check, color: AppColors.green500, size: 32),
                ),
                const SizedBox(height: 16),
                Text(
                  "Investment Successful",
                  style: AppTextStyles.h3SemiBold.copyWith(
                    color: AppColors.white100,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Your mutual fund purchase has been completed successfully.",
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
                    /// ================= FUND NAME =================
                    Text(
                      "Fund Name",
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$fundName - Direct Growth",
                      style: AppTextStyles.body3SemiBold,
                    ),

                    const SizedBox(height: 24),

                    /// ================= AMOUNT INVESTED =================
                    Text(
                      "Amount Invested",
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₹${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      style: AppTextStyles.h3SemiBold,
                    ),

                    const SizedBox(height: 24),

                    /// ================= ORDER ID =================
                    Text(
                      "Order ID",
                      style: AppTextStyles.body5Regular.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text("MF202602081234", style: AppTextStyles.body3SemiBold),

                    const SizedBox(height: 24),

                    /// ================= INFO =================
                    Text(
                      "Units will be allotted as per the applicable NAV.",
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
                    color: AppColors.green500,
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
                            "View Portfolio",
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
                Text(
                  "Confirmation has been sent to your registered email and mobile number",
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
    );
  }
}
