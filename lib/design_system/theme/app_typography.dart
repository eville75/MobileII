// lib/design_system/theme/app_typography.dart
import 'package:flutter/material.dart';
import 'package:mobile/design_system/theme/app_colors.dart';

class AppTypography {
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.accent,
  );
  static const TextStyle componentTitle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
}