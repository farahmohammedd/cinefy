import 'package:cinefy_app/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:cinefy_app/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cinefy_app/core/error/exceptions.dart';
import 'package:cinefy_app/core/error/failures.dart';

class MockMovieRemoteDataSource extends Mock implements MovieRemoteDataSource {}

void main() {
  // =========================
  // Popular Movies - Success
  // =========================

  test('should return movies from data source', () async {
    final dataSource = MockMovieRemoteDataSource();
    final repository = MovieRepositoryImpl(dataSource);

    when(() => dataSource.getPopularMovies()).thenAnswer((_) async => []);

    final result = await repository.getPopularMovies();

    expect(result, []);

    verify(() => dataSource.getPopularMovies()).called(1);
  });

  // =========================
  // Popular Movies - Network Error
  // =========================

  test(
    'should throw NetworkFailure when data source throws NetworkException',
    () async {
      final dataSource = MockMovieRemoteDataSource();
      final repository = MovieRepositoryImpl(dataSource);

      when(() => dataSource.getPopularMovies()).thenThrow(NetworkException());

      expect(
        () => repository.getPopularMovies(),
        throwsA(isA<NetworkFailure>()),
      );
    },
  );

  // =========================
  // Popular Movies - Server Error
  // =========================

  test(
    'should throw ServerFailure when data source throws ServerException',
    () async {
      final dataSource = MockMovieRemoteDataSource();
      final repository = MovieRepositoryImpl(dataSource);

      when(() => dataSource.getPopularMovies()).thenThrow(ServerException());

      expect(
        () => repository.getPopularMovies(),
        throwsA(isA<ServerFailure>()),
      );
    },
  );

  // =========================
  // Popular Movies - Unauthorized
  // =========================

  test(
    'should throw UnauthorizedFailure when data source throws UnauthorizedException',
    () async {
      final dataSource = MockMovieRemoteDataSource();
      final repository = MovieRepositoryImpl(dataSource);

      when(
        () => dataSource.getPopularMovies(),
      ).thenThrow(UnauthorizedException());

      expect(
        () => repository.getPopularMovies(),
        throwsA(isA<UnauthorizedFailure>()),
      );
    },
  );

  // =========================
  // Popular Movies - Not Found
  // =========================

  test(
    'should throw NotFoundFailure when data source throws NotFoundException',
    () async {
      final dataSource = MockMovieRemoteDataSource();
      final repository = MovieRepositoryImpl(dataSource);

      when(() => dataSource.getPopularMovies()).thenThrow(NotFoundException());

      expect(
        () => repository.getPopularMovies(),
        throwsA(isA<NotFoundFailure>()),
      );
    },
  );

  // =========================
  // Popular Movies - Parsing Error
  // =========================

  test(
    'should throw ParsingFailure when data source throws ParsingException',
    () async {
      final dataSource = MockMovieRemoteDataSource();
      final repository = MovieRepositoryImpl(dataSource);

      when(() => dataSource.getPopularMovies()).thenThrow(ParsingException());

      expect(
        () => repository.getPopularMovies(),
        throwsA(isA<ParsingFailure>()),
      );
    },
  );
}
