// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:mobile/data/history_data.dart';
import 'package:mobile/design_system/design_system_screen.dart'; // Importa a tela do DS
import 'package:mobile/design_system/theme/app_colors.dart';
import 'package:mobile/design_system/theme/app_spacing.dart';
import 'package:mobile/design_system/theme/app_typography.dart';
import 'package:mobile/models/playlist_model.dart';
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
          
          const Divider(height: AppSpacing.extraLarge, color: AppColors.accent),

          // BOTÃO PARA O DESIGN SYSTEM
          ListTile(
            leading: const Icon(Icons.palette_outlined, color: AppColors.accent),
            title: Text('Visualizar Design System', style: AppTypography.body.copyWith(color: AppColors.text)),
            subtitle: Text('Documentação de componentes e estilos', style: TextStyle(color: AppColors.accent.withOpacity(0.7))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DesignSystemScreen()),
              );
            },
          ),
          // FIM DO BOTÃO

          const Divider(height: AppSpacing.extraLarge, color: AppColors.accent),

          const Text('Sobre o App', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.medium),
          Text(
            'Pulso v1.0 - Aurora Edition.\nDesenvolvido com Flutter para encontrar a trilha sonora perfeita para cada momento.',
            style: AppTypography.body.copyWith(color: AppColors.accent.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}