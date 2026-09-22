import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:cinefy_app/features/movies/data/models/movie_model.dart';
import 'package:cinefy_app/features/movies/domain/entities/movie.dart';

final favoritesBoxProvider = Provider<Box<MovieModel>>((ref) {
  return Hive.box<MovieModel>('favoritesBox');
});

final favoriteMovieProvider = Provider.family<bool, int>((ref, movieId) {
  final box = ref.watch(favoritesBoxProvider);

  return box.containsKey(movieId);
});

class FavoritesNotifier extends Notifier<List<Movie>> {
  late Box<MovieModel> box;

  @override
  List<Movie> build() {
    box = ref.watch(favoritesBoxProvider);

    return box.values.map((movieModel) {
      return movieModel.toEntity();
    }).toList();
  }

  Future<void> toggleFavorite(Movie movie) async {
    if (box.containsKey(movie.id)) {
      await box.delete(movie.id);
    } else {
      final movieModel = MovieModel.fromEntity(movie);

      await box.put(movie.id, movieModel);
    }

    state = box.values.map((movieModel) {
      return movieModel.toEntity();
    }).toList();
  }

  Future<void> removeFavorite(int movieId) async {
    await box.delete(movieId);

    state = box.values.map((movieModel) {
      return movieModel.toEntity();
    }).toList();
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<Movie>>(
  FavoritesNotifier.new,
);
