// lib/data/theme/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Tema "Aurora"
  
  // Fundo principal da aplicação
  static const Color background = Color(0xFF0D1117);
  // Cor para o final dos gradientes de fundo, criando profundidade
  static const Color backgroundEnd = Color(0xFF161B22);

  // Cor primária vibrante para botões, ícones ativos e destaques
  static const Color primary = Color(0xFF58A6FF); // Um azul brilhante e moderno

  // Cor de destaque secundária (accent) para textos menores ou ícones inativos
  static const Color accent = Color(0xFF8B949E);

  // Cor principal para textos
  static const Color text = Color(0xFFC9D1D9);

  // Cores para o efeito de "vidro fosco" (Glassmorphism)
  static const Color glassEffect = Color(0x1AFFFFFF); // Branco com 10% de opacidade
  static const Color glassBorder = Color(0x33FFFFFF); // Branco com 20% de opacidade

  // Cores de Sentimento adaptadas
  static const Color positive = primary; // O azul primário para positividade
  static const Color negative = Color(0xFFF85149); // Um vermelho forte mas elegante
  static const Color neutral = accent; // O cinza para neutralidade
}