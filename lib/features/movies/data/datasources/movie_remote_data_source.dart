import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:cinefy_app/core/error/error_mapper.dart';
import 'package:cinefy_app/core/error/exceptions.dart';
import 'package:cinefy_app/features/movies/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<MovieModel>> getUpcomingMovies();
  Future<List<MovieModel>> searchMovies(String query);
  Future<MovieModel> getMovieDetails(int movieId);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  MovieRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final Response<Map<String, dynamic>> response = await dio
          .get<Map<String, dynamic>>(
            '/movie/popular',
            queryParameters: {'api_key': dotenv.env['TMDB_API_KEY']},
          );

      final results = response.data?['results'] as List<dynamic>;

      return results
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();
    } on DioException catch (exception) {
      throw mapDioExceptionToException(exception);
    } on FormatException {
      throw ParsingException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final Response<Map<String, dynamic>> response = await dio
          .get<Map<String, dynamic>>(
            '/movie/top_rated',
            queryParameters: {'api_key': dotenv.env['TMDB_API_KEY']},
          );

      final results = response.data?['results'] as List<dynamic>;

      return results
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();
    } on DioException catch (exception) {
      throw mapDioExceptionToException(exception);
    } on FormatException {
      throw ParsingException();
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    try {
      final Response<Map<String, dynamic>> response = await dio
          .get<Map<String, dynamic>>(
            '/movie/upcoming',
            queryParameters: {'api_key': dotenv.env['TMDB_API_KEY']},
          );

      final results = response.data?['results'] as List<dynamic>;

      return results
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();
    } on DioException catch (exception) {
      throw mapDioExceptionToException(exception);
    } on FormatException {
      throw ParsingException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final Response<Map<String, dynamic>> response = await dio
          .get<Map<String, dynamic>>(
            '/search/movie',
            queryParameters: {
              'api_key': dotenv.env['TMDB_API_KEY'],
              'query': query,
            },
          );

      final results = response.data?['results'] as List<dynamic>;

      return results
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();
    } on DioException catch (exception) {
      throw mapDioExceptionToException(exception);
    } on FormatException {
      throw ParsingException();
    }
  }

  @override
  Future<MovieModel> getMovieDetails(int movieId) async {
    try {
      final Response<Map<String, dynamic>> response = await dio
          .get<Map<String, dynamic>>(
            '/movie/$movieId',
            queryParameters: {'api_key': dotenv.env['TMDB_API_KEY']},
          );

      return MovieModel.fromJson(response.data!);
    } on DioException catch (exception) {
      throw mapDioExceptionToException(exception);
    } on FormatException {
      throw ParsingException();
    }
  }
}
