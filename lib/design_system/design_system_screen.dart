// lib/design_system/design_system_screen.dart
import 'package:flutter/material.dart';
import 'package:mobile/design_system/theme/app_colors.dart';
import 'package:mobile/design_system/theme/app_spacing.dart';
import 'package:mobile/design_system/theme/app_typography.dart';
import 'package:mobile/design_system/widgets/playlist_card.dart';
import 'package:mobile/design_system/widgets/sentiment_bubble.dart';
import 'package:mobile/models/playlist_model.dart';

class DesignSystemScreen extends StatelessWidget {
  const DesignSystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundEnd,
          elevation: 0,
          title: const Text('Aurora Design System'),
          bottom: const TabBar(
            indicatorColor: AppColors.primary,
            indicatorWeight: 3.0,
            tabs: [
              Tab(text: 'Cores'),
              Tab(text: 'Tipografia'),
              Tab(text: 'Componentes'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildColorsView(),
            _buildTypographyView(),
            _buildComponentsView(),
          ],
        ),
      ),
    );
  }

  Widget _buildColorsView() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      children: const [
        _ColorTile(color: AppColors.background, name: 'Background'),
        _ColorTile(color: AppColors.backgroundEnd, name: 'Background End'),
        _ColorTile(color: AppColors.primary, name: 'Primary'),
        _ColorTile(color: AppColors.accent, name: 'Accent'),
        _ColorTile(color: AppColors.text, name: 'Text'),
        _ColorTile(color: AppColors.glassEffect, name: 'Glass Effect'),
        _ColorTile(color: AppColors.glassBorder, name: 'Glass Border'),
        _ColorTile(color: AppColors.positive, name: 'Positive'),
        _ColorTile(color: AppColors.negative, name: 'Negative'),
      ],
    );
  }

  Widget _buildTypographyView() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      children: const [
        Text('H1 - Como você se sente agora?', style: AppTypography.h1),
        Divider(height: AppSpacing.large),
        Text('H2 - Histórico de Playlists', style: AppTypography.h2),
        Divider(height: AppSpacing.large),
        Text(
            'Body - Toque em um sentimento para encontrar a playlist perfeita.',
            style: AppTypography.body),
        Divider(height: AppSpacing.large),
        Text('Component Title - Alegria', style: AppTypography.componentTitle),
      ],
    );
  }

  Widget _buildComponentsView() {
    final mockPlaylist = Playlist(
      name: 'Nome da Playlist de Exemplo para Teste de Quebra de Linha',
      mood: 'Sentimento',
      url: '#',
      thumbnailUrl: 'https://i.scdn.co/image/ab67616d0000b273b2592bea12d72421c27942f2',
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sentiment Bubble', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.medium),
          Wrap(
            spacing: AppSpacing.medium,
            children: [
              SentimentBubble(sentiment: 'Positivo', color: AppColors.positive, onTap: () {}),
              SentimentBubble(sentiment: 'Negativo', color: AppColors.negative, onTap: () {}),
              SentimentBubble(sentiment: 'Neutro', color: AppColors.neutral, onTap: () {}),
            ],
          ),
          const Divider(height: AppSpacing.extraLarge),
          const Text('Playlist Card', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.medium),
          SizedBox(
            width: 150,
            height: 200,
            child: PlaylistCard(playlist: mockPlaylist, onTap: () {}),
          ),
        ],
      ),
    );
  }
}

class _ColorTile extends StatelessWidget {
  final Color color;
  final String name;
  const _ColorTile({required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: color == AppColors.background ? AppColors.accent : Colors.transparent),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Text(
          name,
          style: TextStyle(
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}