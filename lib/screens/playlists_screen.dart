import 'package:flutter/material.dart';
import 'package:mobile/models/playlist_model.dart';
import '../data/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlaylistsScreen extends StatefulWidget {
  final String mood;
  const PlaylistsScreen({super.key, required this.mood});

  @override
  _PlaylistsScreenState createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  late Future<List<Playlist>> _playlistsFuture;
  final String _youtubeApiKey = "AIzaSyDrafrqNdnxdjbnJHGwYGuZWAt1adaqokw";

  @override
  void initState() {
    super.initState();
    _playlistsFuture = _fetchPlaylists();
  }

  Future<List<Playlist>> _fetchPlaylists() async {
    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=${widget.mood}+playlist&type=playlist&key=$_youtubeApiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> items = data['items'];
      return items.map((item) {
        return Playlist(
          name: item['snippet']['title'],
          mood: widget.mood,
          url: "https://www.youtube.com/playlist?list=${item['id']['playlistId']}",
          thumbnailUrl: item['snippet']['thumbnails']['high']['url'],
        );
      }).toList();
    } else {
      throw Exception('Erro ao carregar as playlists');
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Não foi possível abrir a URL: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  playlist.thumbnailUrl!,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 150),
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
      body: FutureBuilder<List<Playlist>>(
        future: _playlistsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma playlist encontrada.'));
          } else {
            final playlists = snapshot.data!;
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Playlists de ${widget.mood}',
                            style: const TextStyle(
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
                      Text(
                        'Mixes para você',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 220,
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
            );
          }
        },
      ),
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