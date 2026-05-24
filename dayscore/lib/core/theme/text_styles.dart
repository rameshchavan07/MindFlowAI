import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class TextStyles {
  // Heading font family: Poppins
  static TextStyle get headingStyle => GoogleFonts.poppins(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      );

  // Body font family: Inter
  static TextStyle get bodyStyle => GoogleFonts.inter(
        color: AppColors.textSecondary,
      );

  // Typography Scale
  static TextStyle get h1 => headingStyle.copyWith(
        fontSize: 32.0,
        height: 1.25,
      );

  static TextStyle get h2 => headingStyle.copyWith(
        fontSize: 24.0,
        height: 1.3,
      );

  static TextStyle get h3 => headingStyle.copyWith(
        fontSize: 20.0,
        height: 1.35,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get subtitle1 => bodyStyle.copyWith(
        fontSize: 16.0,
        height: 1.4,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle get subtitle2 => bodyStyle.copyWith(
        fontSize: 14.0,
        height: 1.4,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodyLarge => bodyStyle.copyWith(
        fontSize: 16.0,
        height: 1.5,
      );

  static TextStyle get bodyMedium => bodyStyle.copyWith(
        fontSize: 14.0,
        height: 1.5,
      );

  static TextStyle get bodySmall => bodyStyle.copyWith(
        fontSize: 12.0,
        height: 1.5,
        color: AppColors.textMuted,
      );

  static TextStyle get button => headingStyle.copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: AppColors.surfaceDark,
      );

  static TextStyle get label => headingStyle.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );
}
