import 'package:flutter/material.dart';
import 'package:mobile/data/sentiment_data.dart';
import 'package:mobile/screens/playlists_screen.dart';
import '../data/theme/colors.dart';

class SentimentsScreen extends StatelessWidget {
  const SentimentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha seu Sentimento'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: allSentiments.keys.map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      category,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: allSentiments[category]!.map((sentiment) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaylistsScreen(mood: sentiment),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: AppColors.accent.withOpacity(0.3),
                              width: 1.0,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                          child: Text(
                            sentiment,
                            style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}