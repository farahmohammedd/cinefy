import 'package:cinefy_app/features/movies/presentation/providers/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:cinefy_app/features/movies/domain/entities/movie.dart';
import 'package:cinefy_app/features/movies/domain/usecases/get_movie_details.dart';
import 'package:cinefy_app/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:cinefy_app/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:cinefy_app/features/movies/domain/usecases/get_upcoming_movies.dart';
import 'package:cinefy_app/features/movies/domain/usecases/search_movies.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

class MockGetUpcomingMovies extends Mock implements GetUpcomingMovies {}

class MockGetMovieDetails extends Mock implements GetMovieDetails {}

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  // ============================================================
  // Popular Movies - Success
  // ============================================================

  test('should return popular movies on success', () async {
    final mockGetPopularMovies = MockGetPopularMovies();

    final container = ProviderContainer(
      overrides: [
        getPopularMoviesProvider.overrideWithValue(mockGetPopularMovies),
      ],
    );

    when(() => mockGetPopularMovies()).thenAnswer((_) async => []);

    final result = await container.read(moviesProvider.future);

    expect(result, []);

    verify(() => mockGetPopularMovies()).called(1);

    container.dispose();
  });

  // ============================================================
  // Popular Movies - Error
  // ============================================================

  test('should set error state when loading popular movies fails', () async {
    final mockGetPopularMovies = MockGetPopularMovies();

    final container = ProviderContainer(
      overrides: [
        getPopularMoviesProvider.overrideWithValue(mockGetPopularMovies),
      ],
    );

    // First build succeeds
    when(() => mockGetPopularMovies()).thenAnswer((_) async => []);

    await container.read(moviesProvider.future);

    // Second call fails
    when(
      () => mockGetPopularMovies(),
    ).thenThrow(Exception('Failed to load movies'));

    final notifier = container.read(moviesProvider.notifier);

    await notifier.loadMovies();

    final state = container.read(moviesProvider);

    expect(state, isA<AsyncError<List<Movie>>>());
    expect(state.hasError, true);
    expect(state.error, isA<Exception>());

    verify(() => mockGetPopularMovies()).called(2);

    container.dispose();
  });

  // ============================================================
  // Top Rated Movies - Success
  // ============================================================

  test('should return top rated movies on success', () async {
    final mockGetTopRatedMovies = MockGetTopRatedMovies();

    final container = ProviderContainer(
      overrides: [
        getTopRatedMoviesProvider.overrideWithValue(mockGetTopRatedMovies),
      ],
    );

    when(() => mockGetTopRatedMovies()).thenAnswer((_) async => []);

    final result = await container.read(topRatedMoviesNotifierProvider.future);

    expect(result, []);

    verify(() => mockGetTopRatedMovies()).called(1);

    container.dispose();
  });

  // ============================================================
  // Top Rated Movies - Error
  // ============================================================

  test('should set error state when loading top rated movies fails', () async {
    final mockGetTopRatedMovies = MockGetTopRatedMovies();

    final container = ProviderContainer(
      overrides: [
        getTopRatedMoviesProvider.overrideWithValue(mockGetTopRatedMovies),
      ],
    );

    // First build succeeds
    when(() => mockGetTopRatedMovies()).thenAnswer((_) async => []);

    await container.read(topRatedMoviesNotifierProvider.future);

    // Second call fails
    when(
      () => mockGetTopRatedMovies(),
    ).thenThrow(Exception('Failed to load top rated movies'));

    final notifier = container.read(topRatedMoviesNotifierProvider.notifier);

    await notifier.loadTopRatedMovies();

    final state = container.read(topRatedMoviesNotifierProvider);

    expect(state, isA<AsyncError<List<Movie>>>());
    expect(state.hasError, true);
    expect(state.error, isA<Exception>());

    verify(() => mockGetTopRatedMovies()).called(2);

    container.dispose();
  });

  // ============================================================
  // Search Movies - Success
  // ============================================================

  test('should return search results on success', () async {
    final mockGetPopularMovies = MockGetPopularMovies();
    final mockSearchMovies = MockSearchMovies();

    final container = ProviderContainer(
      overrides: [
        getPopularMoviesProvider.overrideWithValue(mockGetPopularMovies),
        searchMoviesProvider.overrideWithValue(mockSearchMovies),
      ],
    );

    // Initial build
    when(() => mockGetPopularMovies()).thenAnswer((_) async => []);

    // Search succeeds
    when(() => mockSearchMovies('Batman')).thenAnswer((_) async => []);

    await container.read(moviesProvider.future);

    final notifier = container.read(moviesProvider.notifier);

    await notifier.searchMovies('Batman');

    final state = container.read(moviesProvider);

    expect(state.value, []);

    verify(() => mockSearchMovies('Batman')).called(1);

    container.dispose();
  });

  // ============================================================
  // Search Movies - Error
  // ============================================================

  test('should set error state when search movies fails', () async {
    final mockGetPopularMovies = MockGetPopularMovies();
    final mockSearchMovies = MockSearchMovies();

    final container = ProviderContainer(
      overrides: [
        getPopularMoviesProvider.overrideWithValue(mockGetPopularMovies),
        searchMoviesProvider.overrideWithValue(mockSearchMovies),
      ],
    );

    // Initial build succeeds
    when(() => mockGetPopularMovies()).thenAnswer((_) async => []);

    await container.read(moviesProvider.future);

    // Search fails
    when(
      () => mockSearchMovies('Batman'),
    ).thenThrow(Exception('Search failed'));

    final notifier = container.read(moviesProvider.notifier);

    await notifier.searchMovies('Batman');

    final state = container.read(moviesProvider);

    expect(state, isA<AsyncError<List<Movie>>>());
    expect(state.hasError, true);
    expect(state.error, isA<Exception>());

    verify(() => mockSearchMovies('Batman')).called(1);

    container.dispose();
  });

  // ============================================================
  // Upcoming Movies - Success
  // ============================================================

  test('should return upcoming movies on success', () async {
    final mockGetUpcomingMovies = MockGetUpcomingMovies();

    final container = ProviderContainer(
      overrides: [
        getUpcomingMoviesProvider.overrideWithValue(mockGetUpcomingMovies),
      ],
    );

    when(() => mockGetUpcomingMovies()).thenAnswer((_) async => []);

    final result = await container.read(upcomingMoviesProvider.future);

    expect(result, []);

    verify(() => mockGetUpcomingMovies()).called(1);

    container.dispose();
  });

  // ============================================================
  // Upcoming Movies - Error
  // ============================================================

  test('should return error when loading upcoming movies fails', () async {
    final mockGetUpcomingMovies = MockGetUpcomingMovies();

    final container = ProviderContainer(
      overrides: [
        getUpcomingMoviesProvider.overrideWithValue(mockGetUpcomingMovies),
      ],
    );

    when(
      () => mockGetUpcomingMovies(),
    ).thenThrow(Exception('Failed to load upcoming movies'));

    final provider = upcomingMoviesProvider;

    // Start provider
    container.read(provider);

    // Wait until Riverpod processes the async error
    await Future<void>.delayed(Duration.zero);

    final state = container.read(provider);

    expect(state.hasError, true);
    expect(state.error, isA<Exception>());

    verify(() => mockGetUpcomingMovies()).called(1);

    container.dispose();
  });

  // ============================================================
  // Movie Details - Success
  // ============================================================

  test('should return movie details on success', () async {
    final mockGetMovieDetails = MockGetMovieDetails();

    const movieId = 123;

    const movie = Movie(
      id: 123,
      title: 'Batman',
      posterPath: '/poster.jpg',
      backdropPath: '/backdrop.jpg',
      overview: 'Batman movie overview',
      voteAverage: 8.5,
      voteCount: 1000,
      releaseDate: '2026-01-01',
      genreIds: [28, 80],
    );

    final container = ProviderContainer(
      overrides: [
        getMovieDetailsProvider.overrideWithValue(mockGetMovieDetails),
      ],
    );

    when(() => mockGetMovieDetails(movieId)).thenAnswer((_) async => movie);

    final result = await container.read(movieDetailsProvider(movieId).future);

    expect(result, movie);

    verify(() => mockGetMovieDetails(movieId)).called(1);

    container.dispose();
  });

  // ============================================================
  // Movie Details - Error
  // ============================================================

  test('should set error state when loading movie details fails', () async {
    final mockGetMovieDetails = MockGetMovieDetails();

    const movieId = 123;

    final container = ProviderContainer(
      overrides: [
        getMovieDetailsProvider.overrideWithValue(mockGetMovieDetails),
      ],
    );

    when(
      () => mockGetMovieDetails(movieId),
    ).thenThrow(Exception('Failed to load movie details'));

    final provider = movieDetailsProvider(movieId);

    // Start provider
    container.read(provider);

    // Give Riverpod a chance to process the Future
    await Future<void>.delayed(Duration.zero);

    final state = container.read(provider);

    expect(state.hasError, true);
    expect(state.error, isA<Exception>());

    verify(() => mockGetMovieDetails(movieId)).called(1);

    container.dispose();
  });
}
