// lib/main.dart
import 'package:flutter/material.dart';
import 'package:mobile/design_system/theme/app_theme.dart';
import 'package:mobile/screens/sentiments_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Mixer',
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      // Mude para DesignSystemScreen() para ver o catálogo
      home: const SentimentsScreen(), 
    );
  }
}