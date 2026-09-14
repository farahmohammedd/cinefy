class Configuration {
  final String secureBaseUrl;
  final List<String> posterSizes;
  final List<String> backdropSizes;

  Configuration({
    required this.secureBaseUrl,
    required this.posterSizes,
    required this.backdropSizes,
  });
  factory Configuration.fromJson(Map<String, dynamic> json) {
    return Configuration(
      secureBaseUrl: json['secure_base_url'],
      posterSizes: (json['poster_sizes'] as List)
          .map((size) => size.toString())
          .toList(),

      backdropSizes: (json['backdrop_sizes'] as List)
          .map((size) => size.toString())
          .toList(),
    );
  }
}
