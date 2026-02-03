import 'package:flutter/material.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_icons.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_radii.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_text_styles.dart';

class AppSearchBox extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hint;

  const AppSearchBox({
    super.key,
    required this.controller,
    this.onChanged,
    this.hint = "Search",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: AppTextStyles.inputText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.inputText.copyWith(color: AppColors.grey400),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: AppIcons.searchIcon(size: 20, color: AppColors.grey600),
        ),
        filled: true,
        fillColor: AppColors.white100,
        enabledBorder: _border,
        focusedBorder: _border,
      ),
    );
  }

  OutlineInputBorder get _border => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadii.pill),
    borderSide: BorderSide(color: AppColors.grey300),
  );
}

// --------------------------------------------------
// EXAMPLE USAGE
// --------------------------------------------------

// AppSearchBox(
//   controller: searchController,
//   onChanged: (value) {
//     print(value);
//   },
// )
