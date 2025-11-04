// lib/design_system/widgets/sentiment_bubble.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:mobile/design_system/theme/app_colors.dart';
import 'package:mobile/design_system/theme/app_typography.dart';
// IMPORTA O VIEWMODEL
import 'package:mobile/design_system/widgets/viewmodels/sentiment_bubble_viewmodel.dart';

class SentimentBubble extends StatelessWidget {
  final SentimentBubbleViewModel viewModel; // <-- USA O VIEWMODEL
  final VoidCallback onTap;

  const SentimentBubble({
    super.key,
    required this.viewModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: AppColors.glassEffect,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: AppColors.glassBorder, width: 1.5),
            ),
            child: Text(
              viewModel.sentiment, // <-- USA O VIEWMODEL
              style: AppTypography.componentTitle.copyWith(color: viewModel.color), // <-- USA O VIEWMODEL
            ),
          ),
        ),
      ),
    );
  }
}