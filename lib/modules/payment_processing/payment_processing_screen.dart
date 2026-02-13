import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/widgets/rotating_loader.dart';
import '../../app/routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  State<PaymentProcessingScreen> createState() =>
      _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Get.offAllNamed(
          Routes.investmentSuccess,
          arguments: {
            'amount': Get.arguments?['amount'] ?? 5000,
            'fundName': Get.arguments?['fundName'] ?? 'Axis Blue-chip Fund',
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "Processing Your payment",
                style: AppTextStyles.h3SemiBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Please wait while we securely complete your Investment.",
                style: AppTextStyles.body4Regular.copyWith(
                  color: AppColors.grey400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              // Container(
              //   width: 120,
              //   height: 120,
              //   decoration: BoxDecoration(
              //     color: AppColors.primary50,
              //     shape: BoxShape.circle,
              //   ),
              //   child: Center(
              //     child: SizedBox(
              //       width: 60,
              //       height: 60,
              //       child: CircularProgressIndicator(
              //         strokeWidth: 6,
              //         valueColor: AlwaysStoppedAnimation<Color>(
              //           AppColors.primary500,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              RotatingLoader(),
              const SizedBox(height: 60),
              Text(
                "Your investment payment is being processed...",
                style: AppTextStyles.body3SemiBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "This usually takes a few seconds. Do not close.",
                style: AppTextStyles.body4Regular.copyWith(
                  color: AppColors.grey400,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
