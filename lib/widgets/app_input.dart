import 'package:flutter/material.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_borders.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_text_styles.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_input_enum.dart';

class AppInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final AppInputState state;
  final bool isPassword;
  final Widget? suffixIcon;

  const AppInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.state = AppInputState.normal,
    this.isPassword = false,
    this.suffixIcon,
  });

  OutlineInputBorder get _border {
    switch (state) {
      case AppInputState.selected:
        return AppBorders.selected;
      case AppInputState.right:
        return AppBorders.success;
      case AppInputState.wrong:
        return AppBorders.error;
      default:
        return AppBorders.normal;
    }
  }

  Color get _textColor {
    switch (state) {
      case AppInputState.right:
        return AppColors.green500;
      case AppInputState.wrong:
        return AppColors.red500;
      default:
        return AppColors.black100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.inputLabel),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: AppTextStyles.inputText.copyWith(color: _textColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.inputText.copyWith(
              color: AppColors.grey400,
            ),
            border: _border,
            enabledBorder: _border,
            focusedBorder: _border,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

// --------------------------------------------------
// EXAMPLE USAGE:
// --------------------------------------------------

// --------------------------------------------------
// NORMAL
// --------------------------------------------------

// AppInput(
//   label: "Email",
//   hint: "Enter email",
//   controller: emailController,
// )

// --------------------------------------------------
// SELECTED
// --------------------------------------------------

// AppInput(
//   label: "Email",
//   hint: "Enter email",
//   controller: emailController,
//   state: AppInputState.selected,
// )

// --------------------------------------------------
// RIGHT (SUCCESS)
// --------------------------------------------------

// AppInput(
//   label: "Email",
//   hint: "Enter email",
//   controller: emailController,
//   state: AppInputState.right,
// )

// --------------------------------------------------
// WRONG (ERROR)
// --------------------------------------------------

// AppInput(
//   label: "Email",
//   hint: "Enter email",
//   controller: emailController,
//   state: AppInputState.wrong,
// )

// --------------------------------------------------
// INPUT WITH SUFFIX ICON
// --------------------------------------------------

// AppInput(
//   label: "Password",
//   hint: "Enter password",
//   controller: passwordController,
//   isPassword: true,
//   suffixIcon: Icon(Icons.visibility_off),
// )
