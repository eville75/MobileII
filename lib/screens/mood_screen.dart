import 'package:flutter/material.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha seu Humor'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegará para a PlaylistsScreen
              },
              child: const Text('Relaxado'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navegará para a PlaylistsScreen
              },
              child: const Text('Animado'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navegará para a PlaylistsScreen
              },
              child: const Text('Foco'),
            ),
          ],
        ),
      ),
    );
  }
}