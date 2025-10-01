// lib/screens/playlists_screen.dart
import 'package:flutter/material.dart';
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
  // ALTERADO: Lógica de estado para rolagem infinita
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
    _fetchPlaylists(); // Busca a primeira página
    _scrollController.addListener(_onScroll); // Adiciona o listener para a rolagem
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Se o usuário está perto do fim da lista, não estamos carregando e ainda há mais playlists...
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300 &&
        !_isLoading &&
        _hasMore) {
      _fetchPlaylists(); // ...buscamos a próxima página.
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
      // Tratar erro, se necessário
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Não foi possível abrir a URL: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo (mantido)
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
          
          // ALTERADO: Lida com o carregamento inicial
          if (_isInitialLoad && _isLoading)
            const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            
          // Conteúdo principal
          SafeArea(
            child: CustomScrollView(
              controller: _scrollController, // Conecta o controller
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: false,
                  pinned: true,
                  expandedHeight: 120,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    title: Text(
                      widget.mood,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                      textAlign: TextAlign.left,
                    ),
                    centerTitle: false,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      // ALTERADO: Cards menores
                      crossAxisCount: 3, // 3 colunas
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75, // Proporção altura/largura
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return PlaylistCard(
                          playlist: _playlists[index],
                          onTap: () => _launchUrl(_playlists[index].url),
                        );
                      },
                      childCount: _playlists.length,
                    ),
                  ),
                ),

                // NOVO: Indicador de carregamento no final da lista
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


class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;

  const PlaylistCard({super.key, required this.playlist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Raio um pouco menor
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
                  // ALTERADO: Fonte menor para o card menor
                  fontSize: 11,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}