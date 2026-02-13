import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:phdcapital_mf_mobile/app/routes.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Profile", style: AppTextStyles.h1SemiBold),
              SizedBox(height: 40),
              InkWell(
                onTap: () => Get.toNamed(Routes.personalDetails),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Personal Details",
                      style: AppTextStyles.body2Regular.copyWith(
                        color: AppColors.primary500,
                      ),
                    ),

                    SvgPicture.asset(
                      "assets/icons/arrow_right_icon.svg",
                      height: 16,
                      width: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Divider(height: 1, thickness: 2, color: AppColors.grey50),
              SizedBox(height: 12),
              InkWell(
                onTap: () => Get.toNamed(Routes.kyc),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "KYC Details",
                      style: AppTextStyles.body2Regular.copyWith(
                        color: AppColors.primary500,
                      ),
                    ),

                    SvgPicture.asset(
                      "assets/icons/arrow_right_icon.svg",
                      height: 16,
                      width: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Divider(height: 1, thickness: 2, color: AppColors.grey50),
              SizedBox(height: 12),
              InkWell(
                onTap: () => Get.toNamed(Routes.riskAssessment),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Risk assessment",
                      style: AppTextStyles.body2Regular.copyWith(
                        color: AppColors.primary500,
                      ),
                    ),

                    SvgPicture.asset(
                      "assets/icons/arrow_right_icon.svg",
                      height: 16,
                      width: 16,
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
}
