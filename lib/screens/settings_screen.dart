// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:mobile/data/history_data.dart';
import 'package:mobile/data/theme/colors.dart';
import 'package:mobile/models/playlist_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Função para abrir a URL, pois o histórico também será clicável
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
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Histórico de Playlists',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'As playlists que você acessou recentemente.',
            style: TextStyle(color: AppColors.accent, fontSize: 14),
          ),
          const SizedBox(height: 20),
          
          if (playlistHistory.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Center(
                child: Text(
                  'Você ainda não acessou\nnenhuma playlist.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.accent.withOpacity(0.7), fontSize: 16),
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
                  title: Text(playlist.name, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
                  subtitle: Text(playlist.mood, style: const TextStyle(color: AppColors.accent)),
                  onTap: () => _launchUrl(playlist.url),
                ),
              );
            }).toList(),
          
          const Divider(height: 60, color: AppColors.accent),

          const Text(
            'Sobre o App',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Mood Mixer v1.1 - Aurora Edition.\nDesenvolvido com Flutter para encontrar a trilha sonora perfeita para cada momento.',
            style: TextStyle(color: AppColors.accent.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}