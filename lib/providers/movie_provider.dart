import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefy_app/repositories/movie_repository.dart';
import 'package:cinefy_app/models/movie.dart';
import 'package:cinefy_app/services/image_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

////////////////////////////////////////////// Favorites///////////////////////

final favoritesBoxProvider = Provider<Box<Movie>>((ref) {
  return Hive.box<Movie>('favoritesBox');
});
final favoriteMovieProvider = Provider.family<Movie?, int>((ref, movieId) {
  final box = ref.read(favoritesBoxProvider);
  return box.get(movieId);
});
class FavoritesNotifier extends Notifier<List<Movie>> {
  late Box<Movie> box;
  @override
  List<Movie> build() {
    box = ref.read(favoritesBoxProvider);
    return box.values.toList();
  }
  Future<void> addFavorite(Movie movie) async {
    await box.put(movie.id, movie);
    await box.flush();
    state = box.values.toList();
  }
  Future<void> removeFavorite(Movie movie) async {
    await box.delete(movie.id);
    state = box.values.toList();
  }
}
final favoritesProvider = NotifierProvider<FavoritesNotifier, List<Movie>>(
  FavoritesNotifier.new,
);


///////////// //////////////////////Movies////////////////////////////////


final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepository();
});

final imageServiceProvider = FutureProvider<ImageService>((ref) async {
  final repositoryconfigration = ref.read(movieRepositoryProvider);
  final configuration = await repositoryconfigration.fetchConfiguration();
  return ImageService(configuration: configuration);
});

final movieDetailsProvider = FutureProvider.family<Movie, int>((
  ref,
  movieId,
) async {
  final repository = ref.read(movieRepositoryProvider);
  return repository.fetchMovieDetails(movieId);
});



class MoviesNotifier extends AsyncNotifier<List<Movie>> {
  late MovieRepository repository;
  @override
  Future<List<Movie>> build() async {
    repository = ref.read(movieRepositoryProvider);
    final movies = await repository.fetchMovies();
    return movies;
  }

  Future<void> searchMovies(String query) async {
    state = const AsyncValue.loading();

    try {
      final moviesSearch = await repository.fetchSearchMovies(query);
      state = AsyncValue.data(moviesSearch);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> loadMovies() async {
    state = const AsyncValue.loading();
    try {
      final loadMovie = await repository.fetchMovies();
      state = AsyncValue.data(loadMovie);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final moviesProvider = AsyncNotifierProvider<MoviesNotifier, List<Movie>>(
  MoviesNotifier.new,
);

class TopRatedMoviesNotifier extends AsyncNotifier<List<Movie>> {
  late MovieRepository repository;
  @override
  Future<List<Movie>> build() async {
    repository = ref.read(movieRepositoryProvider);
    final movies = await repository.fetchTopRatedMovies();
    return movies;
  }

  Future<void> loadTopRatedMovies() async {
    state = const AsyncValue.loading();
    try {
      final movies  = await repository.fetchTopRatedMovies();
      state = AsyncValue.data(movies);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final topRatedMoviesProvider  = AsyncNotifierProvider<TopRatedMoviesNotifier, List<Movie>>(
  TopRatedMoviesNotifier.new,
);