// lib/design_system/design_system_data.dart
import 'package:mobile/models/playlist_model.dart';

/// Armazena os dados de exemplo (mock data) para
/// a tela de documentação do Design System.
class DesignSystemData {
  
  /// Dados de exemplo para o componente PlaylistCard
  static final Playlist mockPlaylist = Playlist(
    name: 'Nome da Playlist de Exemplo para Teste de Quebra de Linha',
    mood: 'Sentimento',
    url: '#', // URL de placeholder
    thumbnailUrl: 'https://i.scdn.co/image/ab67616d0000b273b2592bea12d72421c27942f2',
  );

  /// Dados de exemplo para o componente SentimentBubble
  static final List<Map<String, String>> mockSentiments = [
    {'label': 'Positivo', 'type': 'positive'},
    {'label': 'Negativo', 'type': 'negative'},
    {'label': 'Neutro', 'type': 'neutral'},
  ];
}