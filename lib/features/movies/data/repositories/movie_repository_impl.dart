import 'package:cinefy_app/core/error/exceptions.dart';
import 'package:cinefy_app/core/error/failures.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      final movieModels = await remoteDataSource.getPopularMovies();
      return movieModels.map((movieModel) {
        return movieModel.toEntity();
      }).toList();
    } on NetworkException {
      throw NetworkFailure();
    } on ServerException {
      throw ServerFailure();
    } on UnauthorizedException {
      throw UnauthorizedFailure();
    } on NotFoundException {
      throw NotFoundFailure();
    } on ParsingException {
      throw ParsingFailure();
    }
  }

  @override
  Future<List<Movie>> getTopRatedMovies() async {
    try {
      final movieModels = await remoteDataSource.getTopRatedMovies();
      return movieModels.map((movieModel) {
        return movieModel.toEntity();
      }).toList();
    } on NetworkException {
      throw NetworkFailure();
    } on ServerException {
      throw ServerFailure();
    } on UnauthorizedException {
      throw UnauthorizedFailure();
    } on NotFoundException {
      throw NotFoundFailure();
    } on ParsingException {
      throw ParsingFailure();
    }
  }

  @override
  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final movieModels = await remoteDataSource.getUpcomingMovies();
      return movieModels.map((movieModel) {
        return movieModel.toEntity();
      }).toList();
    } on NetworkException {
      throw NetworkFailure();
    } on ServerException {
      throw ServerFailure();
    } on UnauthorizedException {
      throw UnauthorizedFailure();
    } on NotFoundException {
      throw NotFoundFailure();
    } on ParsingException {
      throw ParsingFailure();
    }
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final movieModels = await remoteDataSource.searchMovies(query);
      return movieModels.map((movieModel) {
        return movieModel.toEntity();
      }).toList();
    } on NetworkException {
      throw NetworkFailure();
    } on ServerException {
      throw ServerFailure();
    } on UnauthorizedException {
      throw UnauthorizedFailure();
    } on NotFoundException {
      throw NotFoundFailure();
    } on ParsingException {
      throw ParsingFailure();
    }
  }

  @override
  Future<Movie> getMovieDetails(int movieId) async {
    try {
      final movieModel = await remoteDataSource.getMovieDetails(movieId);
      return movieModel.toEntity();
    } on NetworkException {
      throw NetworkFailure();
    } on ServerException {
      throw ServerFailure();
    } on UnauthorizedException {
      throw UnauthorizedFailure();
    } on NotFoundException {
      throw NotFoundFailure();
    } on ParsingException {
      throw ParsingFailure();
    }
  }
}
