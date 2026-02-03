import 'package:flutter/material.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_radii.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_checkbox_enum.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final AppCheckboxState state;
  final double size;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.state = AppCheckboxState.unchecked,
    this.size = 24,
  });

  bool get _isDisabled => state == AppCheckboxState.disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isDisabled ? null : () => onChanged?.call(!value),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(AppRadii.small),
          border: Border.all(color: _borderColor, width: 2),
        ),
        child: value
            ? Center(
                child: Icon(
                  Icons.check,
                  size: size * 0.6,
                  color: AppColors.white100,
                ),
              )
            : null,
      ),
    );
  }

  Color get _backgroundColor {
    if (_isDisabled) return AppColors.grey200;
    if (value) return AppColors.primary500;
    return AppColors.white100;
  }

  Color get _borderColor {
    if (_isDisabled) return AppColors.grey300;
    if (value) return AppColors.primary500;
    return AppColors.grey400;
  }
}

// --------------------------------------------------
// EXAMPLE USAGE
// --------------------------------------------------

// --------------------------------------------------
// UNCHECKED
// --------------------------------------------------

// AppCheckbox(
//   value: false,
//   onChanged: (v) {},
// )

// --------------------------------------------------
// CHECKED
// --------------------------------------------------

// AppCheckbox(
//   value: true,
//   onChanged: (v) {},
// )

// --------------------------------------------------
// DISABLED
// --------------------------------------------------

// AppCheckbox(
//   value: false,
//   state: AppCheckboxState.disabled,
//   onChanged: null,
// )
