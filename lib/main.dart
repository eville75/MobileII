// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/sentiments_screen.dart';
import 'package:mobile/data/theme/colors.dart';

final ValueNotifier<Brightness> currentBrightness = ValueNotifier(Brightness.dark);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _createTheme(Brightness brightness) {
    // Por enquanto, vamos focar em um tema escuro unificado e elegante.
    // A lógica de light/dark pode ser expandida depois com cores apropriadas.
    final baseTheme = ThemeData(brightness: Brightness.dark);

    return baseTheme.copyWith(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Brightness>(
      valueListenable: currentBrightness,
      builder: (context, brightness, child) {
        return MaterialApp(
          title: 'Mood Mixer',
          theme: _createTheme(Brightness.light), // Usando o mesmo tema por enquanto
          darkTheme: _createTheme(Brightness.dark),
          themeMode: ThemeMode.dark, // Forçando o modo escuro para o design "Aurora"
          debugShowCheckedModeBanner: false,
          home: const SentimentsScreen(),
        );
      },
    );
  }
}