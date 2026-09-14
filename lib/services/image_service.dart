import 'package:cinefy_app/models/configuration.dart';

class ImageService {
  final Configuration configuration;
  ImageService({required this.configuration});

  String getPosterUrl({required String size, required String posterPath}) {
    return '${configuration.secureBaseUrl}$size$posterPath';
  }
}
