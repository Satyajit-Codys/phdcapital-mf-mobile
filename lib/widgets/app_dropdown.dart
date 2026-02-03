import 'package:flutter/material.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_borders.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_icons.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_text_styles.dart';
import 'package:phdcapital_mf_mobile/core/enums/app_dropdown_enum.dart';

class AppDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final AppDropdownState state;

  const AppDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.state = AppDropdownState.normal,
  });

  OutlineInputBorder get _border {
    switch (state) {
      case AppDropdownState.selected:
        return AppBorders.selected;
      case AppDropdownState.disabled:
        return AppBorders.normal;
      default:
        return AppBorders.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: state == AppDropdownState.disabled ? null : onChanged,
      style: AppTextStyles.inputText,
      icon: AppIcons.arrowDownIcon(),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.inputText.copyWith(color: AppColors.grey400),
        border: _border,
        enabledBorder: _border,
        focusedBorder: _border,
      ),
    );
  }
}

// --------------------------------------------------
// EXAMPLE USAGE
// --------------------------------------------------

// AppDropdown<String>(
//   hint: "Select Fund Type",
//   value: selectedFund,
//   items: [
//     DropdownMenuItem(value: "Equity", child: Text("Equity")),
//     DropdownMenuItem(value: "Debt", child: Text("Debt")),
//   ],
//   onChanged: (v) {
//     selectedFund = v;
//   },
// )
