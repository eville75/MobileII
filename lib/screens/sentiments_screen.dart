// lib/screens/sentiments_screen.dart

import 'package:flutter/material.dart';
import 'package:mobile/data/playlist_data.dart';
import 'package:mobile/data/sentiment_data.dart';
import 'package:mobile/screens/playlists_screen.dart';

class SentimentsScreen extends StatelessWidget {
  const SentimentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha seu Sentimento'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: allSentiments.keys.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  category,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ...allSentiments[category]!.map((sentiment) {
                return ListTile(
                  title: Text(sentiment),
                  onTap: () {
                    final filteredPlaylists = allPlaylists
                        .where((p) => p.mood == sentiment)
                        .toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaylistsScreen(playlists: filteredPlaylists),
                      ),
                    );
                  },
                );
              }).toList(),
              const Divider(),
            ],
          );
        }).toList(),
      ),
    );
  }
}