// lib/design_system/widgets/playlist_card.dart
import 'package:flutter/material.dart';
import 'package:mobile/design_system/theme/app_colors.dart';
// IMPORTA O VIEWMODEL
import 'package:mobile/design_system/widgets/viewmodels/playlist_card_viewmodel.dart'; 

class PlaylistCard extends StatelessWidget {
  final PlaylistCardViewModel viewModel; // <-- USA O VIEWMODEL
  final VoidCallback onTap;

  const PlaylistCard({super.key, required this.viewModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.glassBorder.withOpacity(0.5), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                viewModel.thumbnailUrl, // <-- USA O VIEWMODEL
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: AppColors.accent),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Text(
                  viewModel.name, // <-- USA O VIEWMODEL
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}