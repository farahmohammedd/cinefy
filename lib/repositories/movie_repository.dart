import 'package:cinefy_app/services/tmdb_service.dart';
import 'package:cinefy_app/models/movie.dart';
import 'package:cinefy_app/models/configuration.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MovieRepository {
  Future<List<Movie>> fetchMovies() async {
    final box = Hive.box<Movie>('moviesCacheBox');
    try {
      final moviesapi = await getPopularMovies();
      await box.clear();
      for (final movie in moviesapi) {
        await box.put(movie.id, movie);
      }
      return moviesapi;
    } catch (error) {
      if (box.isNotEmpty) {
        return box.values.toList();
      }
      rethrow;
    }
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    final box = Hive.box<Movie>('topRatedCacheBox');
    try {
      final topMovie = await getTopRatedMovies();
      await box.clear();
      for (final movie in topMovie) {
        await box.put(movie.id, movie);
      }
      return topMovie;
    } catch (error) {
      if (box.isNotEmpty) {
        return box.values.toList();
      }
      rethrow;
    }
  }

  Future<Configuration> fetchConfiguration() async {
    final configuration = await getConfiguration();
    return configuration;
  }

  Future<List<Movie>> fetchSearchMovies(String query) async {
    final moviesSearch = await getSearchMovies(query);
    return moviesSearch;
  }

  Future<Movie> fetchMovieDetails(int movieId) async {
    final movieDetails = await getMovieDetails(movieId);
    return movieDetails;
  }
}
