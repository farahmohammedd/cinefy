import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefy_app/injection/injection_container.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movie_details.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';
import '../../domain/usecases/get_upcoming_movies.dart';
import '../../domain/usecases/search_movies.dart';

final getPopularMoviesProvider = Provider<GetPopularMovies>((ref) {
  return GetPopularMovies(movieRepository);
});

final getTopRatedMoviesProvider = Provider<GetTopRatedMovies>((ref) {
  return GetTopRatedMovies(movieRepository);
});

final getUpcomingMoviesProvider = Provider<GetUpcomingMovies>((ref) {
  return GetUpcomingMovies(movieRepository);
});

final searchMoviesProvider = Provider<SearchMovies>((ref) {
  return SearchMovies(movieRepository);
});

final getMovieDetailsProvider = Provider<GetMovieDetails>((ref) {
  return GetMovieDetails(movieRepository);
});

final upcomingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final getUpcomingMovies = ref.read(getUpcomingMoviesProvider);

  return getUpcomingMovies();
});

final movieDetailsProvider = FutureProvider.family<Movie, int>((
  ref,
  movieId,
) async {
  final getMovieDetails = ref.read(getMovieDetailsProvider);
  return getMovieDetails(movieId);
});

////////////////////////// getPopularMovies//////////////////////////////////
////////////////////////// getPopularMovies//////////////////////////////////
class MoviesNotifier extends AsyncNotifier<List<Movie>> {
  @override
  Future<List<Movie>> build() async {
    final getPopularMovies = ref.read(getPopularMoviesProvider);
    return getPopularMovies();
  }

  Future<void> searchMovies(String query) async {
    state = const AsyncLoading();
    try {
      final searchMovies = ref.read(searchMoviesProvider);
      final movies = await searchMovies(query);
      state = AsyncData(movies);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> loadMovies() async {
    state = const AsyncLoading();
    try {
      final getPopularMovies = ref.read(getPopularMoviesProvider);
      final movies = await getPopularMovies();
      state = AsyncData(movies);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

final moviesProvider = AsyncNotifierProvider<MoviesNotifier, List<Movie>>(
  MoviesNotifier.new,
);

///////////////////////////////// TopRatedMoviesNotifier////////////////////////////////////////////////////
///////////////////////////////// TopRatedMoviesNotifier////////////////////////////////////////////////////
class TopRatedMoviesNotifier extends AsyncNotifier<List<Movie>> {
  @override
  Future<List<Movie>> build() async {
    final getTopRatedMovies = ref.read(getTopRatedMoviesProvider);
    return getTopRatedMovies();
  }

  Future<void> loadTopRatedMovies() async {
    state = const AsyncLoading();
    try {
      final getTopRatedMovies = ref.read(getTopRatedMoviesProvider);
      final movies = await getTopRatedMovies();
      state = AsyncData(movies);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

final topRatedMoviesNotifierProvider =
    AsyncNotifierProvider<TopRatedMoviesNotifier, List<Movie>>(
      TopRatedMoviesNotifier.new,
    );
