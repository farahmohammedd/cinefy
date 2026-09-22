import '../entities/movie.dart';

// domain  بيحدد احتياجه فقط وال data  بتتولي التنفيذ
abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies();
  //أي implementation لـ MovieRepository لازم يوفر method اسمها getPopularMovies، وترجعلي Future<List<Movie>>
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Movie>> getUpcomingMovies();
  Future<List<Movie>> searchMovies(String query);
  Future<Movie> getMovieDetails(int movieId);
}
