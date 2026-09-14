import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinefy_app/models/movie.dart';
import 'package:cinefy_app/models/configuration.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
  ),
);

///////////getPopularMovies//////////////////
Future<List<Movie>> getPopularMovies() async {
  final response = await dio.get(
    '/movie/popular',
    queryParameters: {'api_key': dotenv.env['TMDB_API_KEY']},
  );
  return (response.data['results'] as List).map((movie) {
    return Movie.fromJson(movie);
  }).toList();
}

///////////TopRatedMovies//////////////////
Future<List<Movie>> getTopRatedMovies() async {
  final responseTOPR = await dio.get(
    '/movie/top_rated',
    queryParameters: {'api_key': dotenv.env['TMDB_API_KEY']},
  );
  return (responseTOPR.data['results'] as List).map((movie) {
    return Movie.fromJson(movie);
  }).toList();
}
///////////getConfiguration//////////////////

Future<Configuration> getConfiguration() async {
  final configurationResponse = await dio.get(
    '/configuration',
    queryParameters: {'api_key': dotenv.env['TMDB_API_KEY']},
  );
  return Configuration.fromJson(
    configurationResponse.data['images'],
  ); 
}
///////////getSearchMovies//////////////////

Future<List<Movie>> getSearchMovies(String query) async {
  final responseSearch = await dio.get(
    '/search/movie',
    queryParameters: {'api_key': dotenv.env['TMDB_API_KEY'], 'query': query},
  );
  return (responseSearch.data['results'] as List).map((movie) {
    return Movie.fromJson(movie);
  }).toList();
}
///////////getMovieDetails//////////////////

Future<Movie> getMovieDetails(int movieId) async {
  final responseDetails = await dio.get(
    '/movie/$movieId',
    queryParameters: {'api_key': dotenv.env['TMDB_API_KEY']},
  );
  return Movie.fromJson(responseDetails.data);
}
