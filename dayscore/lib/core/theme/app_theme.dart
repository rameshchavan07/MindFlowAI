import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import 'app_theme_extensions.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.lime,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.lime,
        secondary: AppColors.cyan,
        tertiary: AppColors.purple,
        surface: AppColors.surface,
        onPrimary: AppColors.surfaceDark,
        onSecondary: AppColors.surfaceDark,
        onSurface: AppColors.textPrimary,
        onError: AppColors.textPrimary,
        error: AppColors.error,
      ),

      // Custom Typography
      textTheme: TextTheme(
        headlineLarge: TextStyles.h1,
        headlineMedium: TextStyles.h2,
        titleLarge: TextStyles.h3,
        titleMedium: TextStyles.subtitle1,
        titleSmall: TextStyles.subtitle2,
        bodyLarge: TextStyles.bodyLarge,
        bodyMedium: TextStyles.bodyMedium,
        bodySmall: TextStyles.bodySmall,
        labelLarge: TextStyles.label,
      ),

      // App Bar styling
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),

      // Bottom Nav Bar styling (fallback properties, though custom floats are used)
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.lime,
        unselectedItemColor: AppColors.textMuted,
      ),

      // Theme extensions for premium elements like neon gradients and glassmorphism
      extensions: [
        GlassTheme(
          blur: AppSizes.glassBlur,
          opacity: 0.12,
          borderWidth: AppSizes.glassBorderWidth,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          borderColor: AppColors.glassBorder,
          shadowColor: AppColors.glassShadow,
          primaryGradient: const LinearGradient(
            colors: [AppColors.lime, AppColors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          secondaryGradient: const LinearGradient(
            colors: [AppColors.purple, AppColors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          darkSurfaceGradient: const LinearGradient(
            colors: [AppColors.surface, AppColors.surfaceDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ],
    );
  }
}
