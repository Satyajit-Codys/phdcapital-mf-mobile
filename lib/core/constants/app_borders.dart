import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radii.dart';

class AppBorders {
  AppBorders._();

  static OutlineInputBorder normal = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadii.medium),
    borderSide: BorderSide(color: AppColors.grey100),
  );

  static OutlineInputBorder selected = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadii.medium),
    borderSide: BorderSide(color: AppColors.primary500),
  );

  static OutlineInputBorder success = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadii.medium),
    borderSide: BorderSide(color: AppColors.green500),
  );

  static OutlineInputBorder error = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadii.medium),
    borderSide: BorderSide(color: AppColors.red500),
  );
}
