import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/sentiments_screen.dart';
import '../data/theme/colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playlist Finder',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
          background: AppColors.background,
          onPrimary: AppColors.text,
          onBackground: AppColors.text,
          primary: AppColors.primary,
        ),
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.copyWith(
            bodyLarge: const TextStyle(color: AppColors.text),
            bodyMedium: const TextStyle(color: AppColors.text),
            headlineSmall: const TextStyle(color: AppColors.text),
          ),
        ),
        useMaterial3: true,
      ),
      home: const SentimentsScreen(),
    );
  }
}