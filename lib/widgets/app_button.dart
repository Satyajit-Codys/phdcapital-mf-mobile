import 'package:flutter/material.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_radii.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_text_styles.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_button_enum.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonState state;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.variant = AppButtonVariant.fill,
    this.state = AppButtonState.enabled,
  });

  bool get _isDisabled => state == AppButtonState.disabled;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case AppButtonVariant.text:
        return _textButton();

      case AppButtonVariant.link:
        return _linkButton();

      case AppButtonVariant.dashed:
        return _dashedButton();

      case AppButtonVariant.secondary:
        return _outlineButton();

      default:
        return _filledButton();
    }
  }

  // --------------------------------------------------
  // FILLED
  // --------------------------------------------------

  Widget _filledButton() {
    return ElevatedButton(
      onPressed: _isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isDisabled
            ? AppColors.primary200
            : AppColors.primary500,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.medium),
        ),
      ),
      child: Text(title, style: AppTextStyles.buttonMedium),
    );
  }

  // --------------------------------------------------
  // OUTLINE / SECONDARY
  // --------------------------------------------------

  Widget _outlineButton() {
    return OutlinedButton(
      onPressed: _isDisabled ? null : onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: _isDisabled ? AppColors.primary200 : AppColors.primary500,
        ),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.medium),
        ),
      ),
      child: Text(
        title,
        style: AppTextStyles.buttonMedium.copyWith(
          color: _isDisabled ? AppColors.primary200 : AppColors.primary500,
        ),
      ),
    );
  }

  // --------------------------------------------------
  // DASHED
  // --------------------------------------------------

  Widget _dashedButton() {
    return InkWell(
      onTap: _isDisabled ? null : onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.medium),
          border: Border.all(
            color: _isDisabled ? AppColors.primary200 : AppColors.primary500,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.buttonMedium.copyWith(
              color: _isDisabled ? AppColors.primary200 : AppColors.primary500,
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // TEXT
  // --------------------------------------------------

  Widget _textButton() {
    return TextButton(
      onPressed: _isDisabled ? null : onPressed,
      child: Text(
        title,
        style: AppTextStyles.buttonMedium.copyWith(
          color: _isDisabled ? AppColors.grey400 : AppColors.primary500,
        ),
      ),
    );
  }

  // --------------------------------------------------
  // LINK
  // --------------------------------------------------

  Widget _linkButton() {
    return GestureDetector(
      onTap: _isDisabled ? null : onPressed,
      child: Text(
        title,
        style: AppTextStyles.buttonMedium.copyWith(
          decoration: TextDecoration.underline,
          color: _isDisabled ? AppColors.grey400 : AppColors.primary500,
        ),
      ),
    );
  }
}

// --------------------------------------------------
// EXAMPLE USAGE:
// --------------------------------------------------

// --------------------------------------------------
// FILLED BUTTON
// --------------------------------------------------

// AppButton(
//   title: "Continue",
//   variant: AppButtonVariant.fill,
//   onPressed: () {},
// )

// --------------------------------------------------
// DISABLED FILLED BUTTON
// --------------------------------------------------

// AppButton(
//   title: "Continue",
//   variant: AppButtonVariant.fill,
//   state: AppButtonState.disabled,
//   onPressed: () {},
// )

// --------------------------------------------------
// SECONDARY BUTTON
// --------------------------------------------------

// AppButton(
//   title: "Cancel",
//   variant: AppButtonVariant.secondary,
//   onPressed: () {},
// )

// --------------------------------------------------
// DASHED BUTTON
// --------------------------------------------------

// AppButton(
//   title: "Upload Statement",
//   variant: AppButtonVariant.dashed,
//   onPressed: () {},
// )

// --------------------------------------------------
// LINK BUTTON
// --------------------------------------------------

// AppButton(
//   title: "Forgot password?",
//   variant: AppButtonVariant.link,
//   onPressed: () {},
// )
