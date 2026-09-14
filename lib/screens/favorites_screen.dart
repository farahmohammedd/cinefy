import 'package:cinefy_app/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:cinefy_app/providers/movie_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cinefy_app/widgets/error_state.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final imageServiceAsync = ref.watch(imageServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Icon(Icons.favorite_border, size: 80),
                  SizedBox(height: 16),
                  Text('No favorites yet'),
                  SizedBox(height: 16),
                  Text('Start exploring and add your favorite movies!'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: Text('Browse Movies'),
                  ),
                ],
              ),
            )
          : imageServiceAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (myImageService) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 230,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final movie = favorites[index];

                    return MovieCard(
                      movie: movie,
                      imageService: myImageService,
                      width: double.infinity,
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return ErrorState(
                  message: 'Something went wrong',
                  onRetry: () {
                    ref.invalidate(imageServiceProvider);
                  },
                );
              },
            ),
    );
  }
}
