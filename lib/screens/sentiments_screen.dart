// lib/screens/sentiments_screen.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:mobile/data/sentiment_data.dart';
import 'package:mobile/design_system/theme/app_colors.dart';
import 'package:mobile/design_system/theme/app_spacing.dart';
import 'package:mobile/design_system/theme/app_typography.dart';
import 'package:mobile/design_system/widgets/sentiment_bubble.dart';
import 'package:mobile/screens/playlists_screen.dart';
import 'package:mobile/screens/settings_screen.dart';

class SentimentsScreen extends StatelessWidget {
  const SentimentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color getBubbleColor(String category) {
      if (category.contains('Positivos')) return AppColors.positive;
      if (category.contains('Negativos')) return AppColors.negative;
      return AppColors.neutral;
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.background, AppColors.backgroundEnd],
              ),
            ),
          ),
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.2),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.extraLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Como você se\nsente agora?',
                        style: AppTypography.h1,
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings_outlined, color: AppColors.accent, size: 28),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SettingsScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  const Text(
                    'Toque em um sentimento para encontrar a playlist perfeita.',
                    style: AppTypography.body,
                  ),
                  const SizedBox(height: AppSpacing.extraLarge),
                  ...allSentiments.keys.map((category) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: AppTypography.h2.copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: AppSpacing.medium + 4),
                        Wrap(
                          spacing: AppSpacing.medium,
                          runSpacing: AppSpacing.medium,
                          children: allSentiments[category]!.map((sentiment) {
                            return SentimentBubble(
                              sentiment: sentiment,
                              color: getBubbleColor(category),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlaylistsScreen(mood: sentiment),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: AppSpacing.extraLarge),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}