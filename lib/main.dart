// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/sentiments_screen.dart';
import 'package:mobile/data/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(brightness: Brightness.dark);

    return MaterialApp(
      title: 'Mood Mixer',
      theme: baseTheme.copyWith(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: baseTheme.colorScheme.copyWith(
          brightness: Brightness.dark,
          background: AppColors.background,
          onBackground: AppColors.text,
          primary: AppColors.primary,
          secondary: AppColors.accent,
        ),
        textTheme: GoogleFonts.manropeTextTheme(baseTheme.textTheme).apply(
          bodyColor: AppColors.text,
          displayColor: AppColors.text,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: SentimentsScreen(), // ALTERAÇÃO APLICADA AQUI
    );
  }
}