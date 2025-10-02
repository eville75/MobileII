// lib/design_system/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/design_system/theme/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final baseTheme = ThemeData(brightness: Brightness.dark);
    return baseTheme.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: baseTheme.colorScheme.copyWith(
        brightness: Brightness.dark,
        background: AppColors.background,
        onBackground: AppColors.text,
        primary: AppColors.primary,
        secondary: AppColors.accent,
      ),
      textTheme: GoogleFonts.manropeTextTheme(baseTheme.textTheme).apply(
        bodyColor: AppColors.text,
        displayColor: AppColors.text,
      ),
      useMaterial3: true,
    );
  }
}