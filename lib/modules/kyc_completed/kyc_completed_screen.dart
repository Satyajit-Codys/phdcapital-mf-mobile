import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';
import '../../app/routes.dart';

class KycCompletedScreen extends StatelessWidget {
  const KycCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Success Icon
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.green500,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.green500.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.white100,
                  size: 80,
                ),
              ),

              const SizedBox(height: 40),

              // Title
              Text(
                "KYC Completed Successfully",
                style: AppTextStyles.h3SemiBold,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                "Your identity has been verified and your account is now fully active.",
                style: AppTextStyles.body4Regular.copyWith(
                  color: AppColors.grey400,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 3),

              // Bottom message
              Text(
                "You can now start investing in mutual funds with complete security and compliance.",
                style: AppTextStyles.body4Regular.copyWith(
                  color: AppColors.grey400,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Go to Homepage Button
              AppButton(
                title: "Go to Homepage",
                variant: AppButtonVariant.fill,
                state: AppButtonState.enabled,
                onPressed: () {
                  // Navigate to home and remove all previous routes
                  Get.offAllNamed(Routes.home);
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
