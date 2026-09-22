import '../domain/entities/configuration.dart';

class ImageService {
  final Configuration configuration;

  ImageService({required this.configuration});

  String getPosterUrl({required String size, required String posterPath}) {
    return '${configuration.secureBaseUrl}$size$posterPath';
  }

  String getBackdropUrl({required String size, required String backdropPath}) {
    return '${configuration.secureBaseUrl}$size$backdropPath';
  }
}
