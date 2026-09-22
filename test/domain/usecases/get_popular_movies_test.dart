import 'package:cinefy_app/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cinefy_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cinefy_app/features/movies/domain/entities/movie.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

//functionality جاهزه
void main() {
  test('should return popular movies', () async {
    final repository = MockMovieRepository();
    final useCase = GetPopularMovies(repository);

    when(() => repository.getPopularMovies()).thenAnswer((_) async => []);
    final result = await useCase();
    expect(result, []);
    verify(() => repository.getPopularMovies()).called(1);
  });
  test('should return movies from repository', () async {
    final repository = MockMovieRepository();
    final useCase = GetPopularMovies(repository);
    final movies = [
      Movie(
        id: 1,
        title: 'Test Movie',
        posterPath: null,
        backdropPath: null,
        overview: 'Test overview',
        voteAverage: 8.0,
        voteCount: 100,
        releaseDate: '2026-01-01',
        genreIds: [],
      ),
    ];

    when(() => repository.getPopularMovies()).thenAnswer((_) async => movies);
    final result = await useCase();
    expect(result, movies);
    verify(() => repository.getPopularMovies()).called(1);
  });
}
