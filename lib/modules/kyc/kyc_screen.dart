import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/enums/app_button_enum.dart';
import '../../widgets/app_button.dart';

class KycVerificationScreen extends StatelessWidget {
  const KycVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,

      // 🔽 FIXED CTA
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: AppButton(
          title: "Start KYC",
          variant: AppButtonVariant.fill,
          state: AppButtonState.enabled,
          onPressed: () {
            // Navigate to KYC flow
            Get.toNamed("/aadhaar-kyc");
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _backButton(),
              const SizedBox(height: 24),

              // ---------------- HEADER ----------------
              Text("KYC Verification", style: AppTextStyles.h3SemiBold),
              const SizedBox(height: 6),
              Text(
                "Your account verification is currently in progress.",
                style: AppTextStyles.body4Regular,
              ),

              const SizedBox(height: 16),

              // ---------------- STATUS PILL ----------------
              _statusPill(),

              const SizedBox(height: 24),

              // ---------------- KYC TYPE ----------------
              Text("Type of KYC Required", style: AppTextStyles.h3SemiBold),
              const SizedBox(height: 6),
              Text(
                "Full KYC using Aadhaar and PAN is required to unlock all features",
                style: AppTextStyles.body4Regular,
              ),

              const SizedBox(height: 24),

              // ---------------- PENDING ACTIONS ----------------
              _pendingActionsCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BACK BUTTON
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

  // ---------------------------------------------------------------------------
  // STATUS PILL
  // ---------------------------------------------------------------------------
  Widget _statusPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.orange50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.orange400),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/pending_icon.svg",
            height: 18,
            width: 18,
            colorFilter: const ColorFilter.mode(
              AppColors.orange500,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Pending",
            style: AppTextStyles.body3SemiBold.copyWith(
              color: AppColors.orange500,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PENDING ACTIONS CARD
  // ---------------------------------------------------------------------------
  Widget _pendingActionsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pending Actions", style: AppTextStyles.body3SemiBold),
          const SizedBox(height: 12),

          _bulletItem("Upload Aadhaar Card"),
          const SizedBox(height: 8),
          _bulletItem("Upload PAN Card"),
          const SizedBox(height: 8),
          _bulletItem("Complete Face Verification"),
        ],
      ),
    );
  }

  Widget _bulletItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3.0),
          child: Container(
            margin: const EdgeInsets.only(top: 6),
            height: 6,
            width: 6,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary500,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: AppTextStyles.body4Regular)),
      ],
    );
  }
}
