import 'package:hive/hive.dart';
part 'movie.g.dart';

//new data type called Movie.
@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String posterPath;
  @HiveField(3)
  final String backdropPath;
  @HiveField(4)
  final String overview;
  @HiveField(5)
  final double voteAverage;
  @HiveField(6)
  final int voteCount;
  @HiveField(7)
  final String releaseDate;
  @HiveField(8)
  final List<int> genreIds;
  @HiveField(9)
  final int? runtime;
  @HiveField(10)
  final List<String> genres;
  // final int runtime;
  //Constructor1
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.genreIds,
    this.runtime,
    this.genres = const [],
  });
  //Constructor2
  //Named Constructor=fromJson
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'],
      genreIds: (json['genre_ids'] as List? ?? [])
          .map((genreId) => genreId as int)
          .toList(),
      genres: (json['genres'] as List? ?? [])
          .map((genre) => genre['name'] as String)
          .toList(),
    );
  }
}
