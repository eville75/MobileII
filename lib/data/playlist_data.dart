// lib/data/playlist_data.dart

import 'package:mobile/models/playlist_model.dart';

final List<Playlist> allPlaylists = [
  // Sentimentos Positivos
  Playlist(name: 'Canções de Alegria', mood: 'Alegria', url: 'https://open.spotify.com/playlist/...'),
  Playlist(name: 'Baladas de Amor', mood: 'Amor', url: 'https://open.spotify.com/playlist/...'),
  Playlist(name: 'Vibes de Otimismo', mood: 'Otimismo', url: 'https://open.spotify.com/playlist/...'),
  
  // Sentimentos Negativos
  Playlist(name: 'Músicas para Chorar', mood: 'Tristeza', url: 'https://open.spotify.com/playlist/...'),
  Playlist(name: 'Para Liberar a Raiva', mood: 'Raiva', url: 'https://open.spotify.com/playlist/...'),
  Playlist(name: 'Solidão e Reflexão', mood: 'Solidão', url: 'https://open.spotify.com/playlist/...'),
  
  // Sentimentos Neutros / Reflexivos
  Playlist(name: 'Sons para Foco', mood: 'Calma', url: 'https://open.spotify.com/playlist/...'),
  Playlist(name: 'Para Viajar na Saudade', mood: 'Nostalgia', url: 'https://open.spotify.com/playlist/...'),
];