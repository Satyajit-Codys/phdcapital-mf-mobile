import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';
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
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTextStyles.inputText,
        textAlignVertical: TextAlignVertical.center, // ✅ IMPORTANT
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.inputText.copyWith(color: AppColors.grey400),
          isDense: true, // ✅ remove extra vertical padding
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0, // ✅ let center handle vertical alignment
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              "assets/icons/search2.svg",
              height: 20,
              width: 20,
              color: AppColors.grey950,
            ),
          ),
          filled: true,
          fillColor: AppColors.white100,
          enabledBorder: _border,
          focusedBorder: _border,
        ),
      ),
    );
  }

  OutlineInputBorder get _border => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadii.medium),
    borderSide: BorderSide(color: AppColors.grey100),
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
