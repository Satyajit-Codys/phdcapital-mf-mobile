import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_radii.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,

    // --------------------------------------------------
    // GLOBAL COLORS
    // --------------------------------------------------
    scaffoldBackgroundColor: AppColors.white100,
    primaryColor: AppColors.primary500,

    colorScheme: ColorScheme.light(
      primary: AppColors.primary500,
      secondary: AppColors.primary400,
      error: AppColors.red500,
      background: AppColors.white100,
    ),

    // --------------------------------------------------
    // GLOBAL FONT
    // --------------------------------------------------
    textTheme: GoogleFonts.urbanistTextTheme(),

    // --------------------------------------------------
    // APP BAR
    // --------------------------------------------------
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white100,
      elevation: 0,
      foregroundColor: AppColors.black100,
      centerTitle: false,
    ),

    // --------------------------------------------------
    // INPUT DEFAULTS
    // --------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadii.medium),
        borderSide: BorderSide(color: AppColors.grey300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadii.medium),
        borderSide: BorderSide(color: AppColors.primary500),
      ),
    ),

    // --------------------------------------------------
    // BUTTON DEFAULTS
    // --------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.white100,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.medium),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.primary500),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.medium),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.primary500),
    ),
  );
}
