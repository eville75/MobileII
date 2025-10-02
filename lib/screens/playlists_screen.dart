// lib/screens/playlists_screen.dart
import 'package:flutter/material.dart';
import 'package:mobile/data/history_data.dart';
import 'package:mobile/models/playlist_model.dart';
import '../data/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

class PlaylistsScreen extends StatefulWidget {
  final String mood;
  const PlaylistsScreen({super.key, required this.mood});

  @override
  _PlaylistsScreenState createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  final String _youtubeApiKey = "AIzaSyDrafrqNdnxdjbnJHGwYGuZWAt1adaqokw";
  final List<Playlist> _playlists = [];
  final ScrollController _scrollController = ScrollController();
  String? _nextPageToken;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    _fetchPlaylists();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300 &&
        !_isLoading &&
        _hasMore) {
      _fetchPlaylists();
    }
  }

  Future<void> _fetchPlaylists() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    String url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=15&q=${widget.mood}+playlist&type=playlist&key=$_youtubeApiKey';
    if (_nextPageToken != null) {
      url += '&pageToken=$_nextPageToken';
    }

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> items = data['items'];
        final newPlaylists = items.map((item) {
          return Playlist(
            name: item['snippet']['title'],
            mood: widget.mood,
            url: "https://www.youtube.com/playlist?list=${item['id']['playlistId']}",
            thumbnailUrl: item['snippet']['thumbnails']['high']['url'],
          );
        }).toList();

        setState(() {
          _playlists.addAll(newPlaylists);
          _nextPageToken = data['nextPageToken'];
          _hasMore = _nextPageToken != null;
          _isInitialLoad = false;
        });
      } else {
        throw Exception('Erro ao carregar as playlists');
      }
    } catch (e) {
      // Tratar erro
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  Future<void> _handlePlaylistTap(Playlist playlist) async {
    playlistHistory.removeWhere((p) => p.url == playlist.url);
    playlistHistory.insert(0, playlist);
    
    if (!await launchUrl(Uri.parse(playlist.url))) {
      throw Exception('Não foi possível abrir a URL: ${playlist.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            top: -50,
            right: -150,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.2),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          
          if (_isInitialLoad && _isLoading)
            const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            
          SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  // ----- INÍCIO DA CORREÇÃO -----
                  backgroundColor: AppColors.background,
                  elevation: 0,
                  pinned: true,
                  expandedHeight: 120,
                  // O FlexibleSpaceBar agora controla o título em todos os estados
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      widget.mood,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.text),
                    ),
                    centerTitle: true, // Centraliza o título quando a barra encolhe
                    titlePadding: const EdgeInsets.only(bottom: 16.0), // Ajusta o padding
                  ),
                   // ----- FIM DA CORREÇÃO -----
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final playlist = _playlists[index];
                        return PlaylistCard(
                          playlist: playlist,
                          onTap: () => _handlePlaylistTap(playlist),
                        );
                      },
                      childCount: _playlists.length,
                    ),
                  ),
                ),

                if (_isLoading && !_isInitialLoad)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
                    ),
                  ),

                SliverToBoxAdapter(child: const SizedBox(height: 40)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// O widget PlaylistCard continua o mesmo
class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;

  const PlaylistCard({super.key, required this.playlist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.glassBorder.withOpacity(0.5), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                playlist.thumbnailUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: AppColors.accent),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Text(
                  playlist.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}