import 'package:flutter/material.dart';
import 'package:mobile/models/playlist_model.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suas Playlists'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: playlists.isEmpty
          ? const Center(
              child: Text('Nenhuma playlist encontrada para este humor.'),
            )
          : ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(playlist.name),
                    subtitle: Text(playlist.mood),
                    onTap: () => _launchUrl(playlist.url),
                  ),
                );
              },
            ),
    );
  }
}