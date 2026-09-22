import 'package:cinefy_app/features/configuration/domain/entities/configuration.dart';

class ConfigurationModel {
  final String secureBaseUrl;
  final List<String> posterSizes;
  final List<String> backdropSizes;

  const ConfigurationModel({
    required this.secureBaseUrl,
    required this.posterSizes,
    required this.backdropSizes,
  });

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) {
    return ConfigurationModel(
      secureBaseUrl: json['secure_base_url'] as String? ?? '',
      posterSizes: List<String>.from(
        (json['poster_sizes'] as List<dynamic>?) ?? [],
      ),
      backdropSizes: List<String>.from(
        (json['backdrop_sizes'] as List<dynamic>?) ?? [],
      ),
    );
  }

  Configuration toEntity() {
    return Configuration(
      secureBaseUrl: secureBaseUrl,
      posterSizes: posterSizes,
      backdropSizes: backdropSizes,
    );
  }
}
