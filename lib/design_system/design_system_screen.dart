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
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundEnd,
          elevation: 0,
          title: const Text('Design System'),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: AppColors.primary,
            indicatorWeight: 3.0,
            tabs: [
              Tab(text: 'Cores'),
              Tab(text: 'Tipografia'),
              Tab(text: 'Espaçamentos'),
              Tab(text: 'Componentes'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildColorsView(),
            _buildTypographyView(),
            _buildSpacingView(),
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
        Text('Paleta Principal', style: AppTypography.h2),
        SizedBox(height: AppSpacing.medium),
        _ColorTile(
          color: AppColors.primary,
          name: 'Primary',
          usage: 'Botões principais, links, ícones ativos e indicadores.',
        ),
        _ColorTile(
          color: AppColors.accent,
          name: 'Accent',
          usage: 'Textos secundários, ícones inativos e bordas sutis.',
        ),
        _ColorTile(
          color: AppColors.text,
          name: 'Text',
          usage: 'Cor principal para todos os textos sobre fundos escuros.',
        ),
        _ColorTile(
          color: AppColors.background,
          name: 'Background',
          usage: 'Cor de fundo principal e base para a maioria das telas.',
        ),
        _ColorTile(
          color: AppColors.backgroundEnd,
          name: 'Background End',
          usage: 'Cor final para gradientes de fundo, criando profundidade.',
        ),
        
        Divider(height: AppSpacing.extraLarge, color: AppColors.accent),

        Text('Efeitos e Transparências', style: AppTypography.h2),
        SizedBox(height: AppSpacing.medium),
        _ColorTile(
          color: AppColors.glassEffect,
          name: 'Glass Effect',
          usage: 'Fundo para componentes com efeito de vidro fosco.',
        ),
        _ColorTile(
          color: AppColors.glassBorder,
          name: 'Glass Border',
          usage: 'Borda para componentes com efeito de vidro fosco.',
        ),

        Divider(height: AppSpacing.extraLarge, color: AppColors.accent),

        Text('Cores Semânticas', style: AppTypography.h2),
        SizedBox(height: AppSpacing.medium),
        _ColorTile(
          color: AppColors.positive,
          name: 'Positive',
          usage: 'Representa sucesso ou sentimentos positivos. (Alias para Primary)',
        ),
        _ColorTile(
          color: AppColors.negative,
          name: 'Negative (Error)',
          usage: 'Representa erro, perigo ou sentimentos negativos.',
        ),
        _ColorTile(
          color: AppColors.neutral,
          name: 'Neutral',
          usage: 'Representa estado neutro ou informativo. (Alias para Accent)',
        ),
      ],
    );
  }
  
  Widget _buildTypographyView() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      children: const [
        _TypographyTile(
          name: 'H1',
          style: AppTypography.h1,
          exampleText: 'Como você se sente agora?',
        ),
        _TypographyTile(
          name: 'H2',
          style: AppTypography.h2,
          exampleText: 'Histórico de Playlists',
        ),
        _TypographyTile(
          name: 'Body',
          style: AppTypography.body,
          exampleText: 'Toque em um sentimento para encontrar a playlist perfeita.',
        ),
        _TypographyTile(
          name: 'Component Title',
          style: AppTypography.componentTitle,
          exampleText: 'Alegria',
        ),
      ],
    );
  }

  Widget _buildSpacingView() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      children: const [
        _SpacingTile(
          name: 'Small',
          size: AppSpacing.small,
          concept: 'Agrupador',
          description: 'Use para conectar elementos que devem ser lidos como uma única unidade (ex: título e subtítulo).',
        ),
        _SpacingTile(
          name: 'Medium',
          size: AppSpacing.medium,
          concept: 'Separador Padrão',
          description: 'O espaço mais comum. Use entre itens distintos, como os cards em uma lista ou os bubbles de sentimento.',
        ),
        _SpacingTile(
          name: 'Large',
          size: AppSpacing.large,
          concept: 'Separador de Seções',
          description: 'Use para criar uma divisão clara entre grandes blocos de conteúdo e como padding principal da tela.',
        ),
        _SpacingTile(
          name: 'Extra Large',
          size: AppSpacing.extraLarge,
          concept: 'Grande Respiro',
          description: 'Use para os maiores espaços estruturais, geralmente no início ou no fim de uma página.',
        ),
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
  final String? subtitle;
  final String? usage;

  const _ColorTile({required this.color, required this.name, this.subtitle, this.usage});

  String get hexCode {
    return '#${color.value.toRadixString(16).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = color.computeLuminance() < 0.5;
    final Color textColor = isDark ? Colors.white : Colors.black;

    return Card(
      color: color,
      margin: const EdgeInsets.only(bottom: AppSpacing.medium),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: color == AppColors.background ? AppColors.accent : Colors.transparent),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(subtitle!, style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 12)),
                      ],
                    ],
                  ),
                ),
                Text(
                  hexCode,
                  style: TextStyle(fontFamily: 'monospace', color: textColor, fontSize: 16),
                ),
              ],
            ),
            if (usage != null) ...[
              const Divider(height: AppSpacing.medium, color: Colors.white24),
              Text(
                'Uso Prático: ${usage!}',
                style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TypographyTile extends StatelessWidget {
  final String name;
  final String exampleText;
  final TextStyle style;
  const _TypographyTile({required this.name, required this.style, required this.exampleText});

  String get styleDetails {
    final size = 'Font Size: ${style.fontSize}';
    final weight = 'Font Weight: ${style.fontWeight.toString().split('.').last}';
    return '$size\n$weight';
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(exampleText, style: style),
          const SizedBox(height: AppSpacing.small),
          Text(
            '$name Details:\n$styleDetails',
            style: AppTypography.body.copyWith(
              color: AppColors.accent.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
           const Divider(height: AppSpacing.large, color: AppColors.accent),
        ],
      ),
    );
  }
}

class _SpacingTile extends StatelessWidget {
  final String name;
  final String concept;
  final String description;
  final double size;
  const _SpacingTile({required this.name, required this.size, required this.concept, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: size,
                height: size,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.medium),
              Text(
                '$name - ${size.toStringAsFixed(1)}px',
                style: AppTypography.componentTitle,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),
          Text(
            'Conceito: "$concept"',
            style: AppTypography.body.copyWith(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.text),
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            description,
            style: AppTypography.body.copyWith(
              color: AppColors.accent.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
          const Divider(height: AppSpacing.large, color: AppColors.accent),
        ],
      ),
    );
  }
}