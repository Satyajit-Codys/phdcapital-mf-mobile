import 'package:flutter/material.dart';
import 'package:phdcapital_mf_mobile/core/constants/app_colors.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const AppSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.white100,
      activeTrackColor: AppColors.primary500,
      inactiveThumbColor: AppColors.white100,
      inactiveTrackColor: AppColors.grey300,
    );
  }
}
