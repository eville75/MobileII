import 'package:flutter/material.dart';
import 'package:mobile/models/playlist_model.dart';
import '../data/theme/colors.dart';

import 'package:url_launcher/url_launcher.dart';

class PlaylistsScreen extends StatelessWidget {
  final List<Playlist> playlists;

  const PlaylistsScreen({super.key, required this.playlists});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Não foi possível abrir a URL: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Usaremos um widget para cada item da playlist para organizar o código
    Widget playlistCard(Playlist playlist) {
      return GestureDetector(
        onTap: () => _launchUrl(playlist.url),
        child: Container(
          width: 150,
          margin: const EdgeInsets.only(right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://i.scdn.co/image/ab67706c0000bebb9c148f95c02b5e282b8426ae', // Imagem de exemplo
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                playlist.name,
                style: const TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                playlist.mood,
                style: const TextStyle(
                  color: AppColors.accent,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (Boa noite)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Boa noite',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, color: AppColors.text),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Seção de Playlists
                Text(
                  'Músicas para seu humor',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                ),
                const SizedBox(height: 16),
                // Carrossel de playlists
                SizedBox(
                  height: 220, // Altura fixa para o carrossel
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: playlists.length,
                    itemBuilder: (context, index) {
                      return playlistCard(playlists[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.card,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.text,
        unselectedItemColor: AppColors.accent,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Sua Biblioteca',
          ),
        ],
      ),
    );
  }
}