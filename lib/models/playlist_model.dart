class Playlist {
  final String name;
  final String mood;
  final String url;
  final String? thumbnailUrl;

  Playlist({
    required this.name,
    required this.mood,
    required this.url,
    this.thumbnailUrl,
  });
}