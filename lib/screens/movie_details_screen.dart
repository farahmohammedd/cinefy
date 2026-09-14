import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cinefy_app/providers/movie_provider.dart';

class MovieDetailsScreen extends ConsumerStatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});
  @override
  ConsumerState<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends ConsumerState<MovieDetailsScreen> {
  String formatRuntime(int? runtime) {
    if (runtime == null || runtime == 0) {
      return 'Unknown';
    }
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    if (hours == 0) {
      return '${minutes}m';
    }
    if (minutes == 0) {
      return '${hours}h';
    }
    return '${hours}h ${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    final movieState = ref.watch(movieDetailsProvider(widget.movieId));
    final imageServiceState = ref.watch(imageServiceProvider);
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      body: movieState.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 50),
                  const SizedBox(height: 16),
                  const Text(
                    'Something went wrong',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('$error', textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ref.invalidate(movieDetailsProvider(widget.movieId));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },

        data: (movie) {
          final isMovieFavorite = favorites.any(
            (favorite) => favorite.id == movie.id,
          );

          return imageServiceState.when(
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (error, stackTrace) {
              return Center(child: Text('Image service error: $error'));
            },

            data: (imageService) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Poster
                    Stack(
                      children: [
                        SizedBox(
                          height: 400,
                          width: double.infinity,
                          child: movie.posterPath.isEmpty
                              ? const Center(child: Icon(Icons.movie, size: 80))
                              : Image.network(
                                  imageService.getPosterUrl(
                                    size: 'w780',
                                    posterPath: movie.posterPath,
                                  ),
                                  height: 400,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),

                        // Back button
                        Positioned(
                          top: 20,
                          left: 20,
                          child: IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Favorite icon
                        Positioned(
                          top: 20,
                          right: 20,
                          child: IconButton(
                            onPressed: () {
                              if (isMovieFavorite) {
                                ref
                                    .read(favoritesProvider.notifier)
                                    .removeFavorite(movie);
                              } else {
                                ref
                                    .read(favoritesProvider.notifier)
                                    .addFavorite(movie);
                              }
                            },
                            icon: Icon(
                              isMovieFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 5),
                          Text(movie.voteAverage.toStringAsFixed(1)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '${movie.releaseDate.isEmpty ? 'Unknown' : movie.releaseDate}  •  '
                        '${formatRuntime(movie.runtime)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),

                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (isMovieFavorite) {
                              ref
                                  .read(favoritesProvider.notifier)
                                  .removeFavorite(movie);
                            } else {
                              ref
                                  .read(favoritesProvider.notifier)
                                  .addFavorite(movie);
                            }
                          },
                          icon: Icon(
                            isMovieFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          label: Text(
                            isMovieFavorite
                                ? 'Added to Favorites'
                                : 'Add to Favorites',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            movie.overview.isEmpty
                                ? 'No overview available.'
                                : movie.overview,
                            style: const TextStyle(height: 1.5),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Genres',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: movie.genres.map((genre) {
                              return Chip(label: Text(genre));
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
