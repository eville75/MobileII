import 'package:flutter/material.dart';
import 'package:mobile/main.dart'; // Para acessar o currentBrightness
import 'package:mobile/data/theme/colors.dart'; // Importação corrigida

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final onBackground = theme.colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações', style: TextStyle(color: onBackground)),
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: onBackground),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Modo Escuro / Claro', style: TextStyle(color: onBackground)),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                currentBrightness.value = value ? Brightness.dark : Brightness.light;
              },
              activeColor: theme.colorScheme.primary,
            ),
          ),
          const Divider(),
          ListTile(
            title: Text('Sobre o App', style: TextStyle(color: onBackground, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'O Playlist Finder é um projeto desenvolvido para a disciplina de Mobile II, utilizando a API do YouTube para sugerir playlists com base em sentimentos. O design é inspirado em uma paleta elegante e moderna.',
              style: TextStyle(color: onBackground.withOpacity(0.7)),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Versão: 1.0.0',
              style: TextStyle(color: onBackground.withOpacity(0.7)),
            ),
          ),
        ],
      ),
    );
  }
}