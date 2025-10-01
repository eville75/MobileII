// lib/screens/sentiments_screen.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:mobile/data/sentiment_data.dart';
import 'package:mobile/screens/playlists_screen.dart';
import '../data/theme/colors.dart';
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
          // Fundo com Gradiente e Efeito Aurora
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

          // Conteúdo da Tela
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Como você se\nsente agora?',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
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
                  const SizedBox(height: 16),
                  const Text(
                    'Toque em um sentimento para encontrar a playlist perfeita.',
                    style: TextStyle(fontSize: 16, color: AppColors.accent),
                  ),
                  const SizedBox(height: 40),
                  ...allSentiments.keys.map((category) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 12.0,
                          runSpacing: 12.0,
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
                        const SizedBox(height: 40),
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

// Widget customizado para o balão de sentimento com efeito de vidro
class SentimentBubble extends StatelessWidget {
  final String sentiment;
  final Color color;
  final VoidCallback onTap;

  const SentimentBubble({
    super.key,
    required this.sentiment,
    required this.color,
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
              sentiment,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}