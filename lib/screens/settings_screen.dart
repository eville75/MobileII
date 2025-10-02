// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:mobile/data/history_data.dart';
import 'package:mobile/design_system/theme/app_colors.dart';
import 'package:mobile/design_system/theme/app_spacing.dart';
import 'package:mobile/design_system/theme/app_typography.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Não foi possível abrir a URL: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.medium),
        children: [
          const Text('Histórico de Playlists', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.small),
          const Text(
            'As playlists que você acessou recentemente.',
            style: AppTypography.body,
          ),
          const SizedBox(height: AppSpacing.large),
          
          if (playlistHistory.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.extraLarge),
              child: Center(
                child: Text(
                  'Você ainda não acessou\nnenhuma playlist.',
                  textAlign: TextAlign.center,
                  style: AppTypography.body.copyWith(color: AppColors.accent.withOpacity(0.7)),
                ),
              ),
            )
          else
            ...playlistHistory.map((playlist) {
              return Card(
                color: AppColors.glassEffect,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColors.glassBorder, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(
                      playlist.thumbnailUrl!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(playlist.name, style: AppTypography.componentTitle),
                  subtitle: Text(playlist.mood, style: const TextStyle(color: AppColors.accent)),
                  onTap: () => _launchUrl(playlist.url),
                ),
              );
            }).toList(),
          
          const Divider(height: 60, color: AppColors.accent),

          const Text('Sobre o App', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.medium),
          Text(
            'Mood Mixer v1.1 - Aurora Edition.\nDesenvolvido com Flutter para encontrar a trilha sonora perfeita para cada momento.',
            style: AppTypography.body.copyWith(color: AppColors.accent.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}