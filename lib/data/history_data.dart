// lib/data/history_data.dart

import 'package:mobile/models/playlist_model.dart';

// Lista global para armazenar o histórico de playlists acessadas.
// O item mais recente sempre será o primeiro da lista.
final List<Playlist> playlistHistory = [];