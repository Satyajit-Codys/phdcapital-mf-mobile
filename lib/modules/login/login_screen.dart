import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phdcapital_mf_mobile/widgets/app_button.dart';
import 'package:phdcapital_mf_mobile/widgets/app_input.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_icons.dart';
import '../../core/enums/app_button_enum.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Stack(
          children: [
            // ---------------------------
            // BACKGROUND IMAGE
            // ---------------------------
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bg.png",
                height: 550,
                fit: BoxFit.cover,
              ),
            ),

            // ---------------------------
            // FOREGROUND CONTENT
            // ---------------------------
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _backButton(),
                  const SizedBox(height: 80), // space for image overlay
                  _header(),
                  const SizedBox(height: 30),
                  _input(),
                  const SizedBox(height: 24),
                  _loginButton(),
                  const SizedBox(height: 24),
                  _divider(),
                  const SizedBox(height: 24),
                  _googleButton(),
                  const SizedBox(height: 16),
                  _appleButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // BACK BUTTON
  // --------------------------------------------------

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
        child: Center(
          child: AppIcons.arrowLeftIcon(size: 18, color: AppColors.black100),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // HEADER
  // --------------------------------------------------

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Login Account", style: AppTextStyles.h2SemiBold),
        const SizedBox(height: 6),
        Text("Welcome Back", style: AppTextStyles.subtitle),
      ],
    );
  }

  // --------------------------------------------------
  // INPUT
  // --------------------------------------------------

  Widget _input() {
    return AppInput(
      label: "Mobile number or Email",
      hint: "+911234567890",
      controller: controller.phoneOrEmailController,
      onChanged: controller.validateInput,
    );
  }

  // --------------------------------------------------
  // LOGIN BUTTON
  // --------------------------------------------------

  Widget _loginButton() {
    return Obx(
      () => AppButton(
        title: "Login",
        variant: AppButtonVariant.fill,
        state: controller.isValid.value
            ? AppButtonState.enabled
            : AppButtonState.disabled,
        onPressed: controller.isValid.value
            ? () {
                final input = controller.phoneOrEmailController.text.trim();

                Get.toNamed("/otp", arguments: {"phone": input});
              }
            : null,
      ),
    );
  }

  // --------------------------------------------------
  // DIVIDER
  // --------------------------------------------------

  Widget _divider() {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text("Or Continue with", style: AppTextStyles.body4Regular),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  // --------------------------------------------------
  // GOOGLE BUTTON
  // --------------------------------------------------

  Widget _googleButton() {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(color: AppColors.grey100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/google_icon.svg", height: 22),
          const SizedBox(width: 10),
          Text("Continue with Google", style: AppTextStyles.body3SemiBold),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // APPLE BUTTON
  // --------------------------------------------------

  Widget _appleButton() {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(color: AppColors.grey100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/apple_icon.svg"),
          SizedBox(width: 10),
          Text("Continue with Apple", style: AppTextStyles.body3SemiBold),
        ],
      ),
    );
  }
}
