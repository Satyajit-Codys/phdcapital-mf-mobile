import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // --------------------------------------------------
  // FONT FAMILY
  // --------------------------------------------------
  // static final TextStyle _base = GoogleFonts.urbanist();

  // --------------------------------------------------
  // HEADINGS
  // --------------------------------------------------

  // H1 - 32px | Line height: 40px
  static TextStyle h1Bold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w700,
    color: AppColors.black100,
  );

  static TextStyle h1SemiBold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w600,
    color: AppColors.black100,
  );

  // H2 - 24px | Line height: 32px
  static TextStyle h2SemiBold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w600,
    color: AppColors.black100,
  );

  static TextStyle h2Medium = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w500,
    color: AppColors.black100,
  );

  // H3 - 20px | Line height: 28px
  static TextStyle h3SemiBold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black100,
  );

  static TextStyle h3Medium = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w500,
    color: AppColors.black100,
  );

  // H4 - 18px | Line height: 26px
  static TextStyle h4SemiBold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.w600,
    color: AppColors.black100,
  );

  static TextStyle h4Medium = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.w500,
    color: AppColors.black100,
  );

  // H5 - 16px | Line height: 24px
  static TextStyle h5SemiBold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black100,
  );

  static TextStyle h5Medium = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black100,
  );

  // H6 - 14px | Line height: 22px
  static TextStyle h6SemiBold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black100,
  );

  static TextStyle h6Medium = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black100,
  );

  // --------------------------------------------------
  // BODY TEXT
  // --------------------------------------------------

  // B1 - 24px | Line height: 32px
  static TextStyle body1SemiBold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w600,
    color: AppColors.grey800,
  );

  static TextStyle body1Regular = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w400,
    color: AppColors.grey800,
  );

  // B2 - 20px | Line height: 28px
  static TextStyle body2SemiBold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
    color: AppColors.grey800,
  );

  static TextStyle body2Regular = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w400,
    color: AppColors.grey800,
  );

  // B3 - 16px | Line height: 24px
  static TextStyle body3SemiBold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
    color: AppColors.grey800,
  );

  static TextStyle body3Regular = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.grey800,
  );

  // B4 - 16px | Line height: 22px
  static TextStyle body4SemiBold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w600,
    color: AppColors.grey700,
  );

  static TextStyle body4Regular = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.grey700,
  );

  static TextStyle subtitle = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w500,
    color: AppColors.grey400,
  );

  // B5 - 14px | Line height: 18px
  static TextStyle body5SemiBold = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 14,
    height: 18 / 14,
    fontWeight: FontWeight.w600,
    color: AppColors.grey700,
  );

  static TextStyle body5Regular = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 14,
    height: 18 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey700,
  );

  // --------------------------------------------------
  // BUTTON TEXT
  // --------------------------------------------------

  // Button 1 - 18px | Line height: 26px
  static TextStyle buttonLarge = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.w600,
    color: AppColors.white100,
  );

  // Button 2 - 16px | Line height: 24px
  static TextStyle buttonMedium = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white100,
  );

  // --------------------------------------------------
  // INPUT TEXT
  // --------------------------------------------------

  // Input Heading - 14px | Line height: 22px
  static TextStyle inputLabel = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w600,
    color: AppColors.grey700,
  );

  // Input Text - 16px | Line height: 24px
  static TextStyle inputText = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black100,
  );

  // --------------------------------------------------
  // CAPTION
  // --------------------------------------------------

  // C1 - 14px | Line height: 22px
  static TextStyle caption1 = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w500,
    color: AppColors.grey600,
  );

  // C2 - 12px | Line height: 20px
  static TextStyle caption2 = TextStyle(
    fontFamily: GoogleFonts.urbanist().fontFamily,
    fontSize: 12,
    height: 20 / 12,
    fontWeight: FontWeight.w500,
    color: AppColors.grey600,
  );
}
