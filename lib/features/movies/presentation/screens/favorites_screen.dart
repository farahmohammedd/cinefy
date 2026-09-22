import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinefy_app/features/configuration/presentation/configuration_provider.dart';
import 'package:cinefy_app/features/movies/presentation/providers/favorites_provider.dart';
import 'package:cinefy_app/features/movies/presentation/widgets/movie_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final imageServiceAsync = ref.watch(imageServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: imageServiceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (imageService) {
          if (favorites.isEmpty) {
            return const Center(child: Text('No favorite movies yet'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 20,
              childAspectRatio: 0.58,
            ),
            itemBuilder: (context, index) {
              final movie = favorites[index];

              return MovieCard(
                movie: movie,
                imageService: imageService,
                width: double.infinity,
              );
            },
          );
        },
      ),
    );
  }
}
