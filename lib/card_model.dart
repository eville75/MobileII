class Card {
  final String name;
  final int elixir;
  final String imageUrl;

  Card({required this.name, required this.elixir, required this.imageUrl});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      name: json['name'],
      elixir: json['elixir'],
      imageUrl: json['iconUrls']['medium'],
    );
  }
}