import 'package:cinefy_app/features/configuration/data/models/configuration_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ConfigurationRemoteDataSource {
  Future<ConfigurationModel> getConfiguration();
}

class ConfigurationRemoteDataSourceImpl
    implements ConfigurationRemoteDataSource {
  final Dio dio;

  ConfigurationRemoteDataSourceImpl(this.dio);

  @override
  Future<ConfigurationModel> getConfiguration() async {
    final response = await dio.get<Map<String, dynamic>>(
      '/configuration',
      queryParameters: {'api_key': dotenv.env['TMDB_API_KEY']},
    );

    return ConfigurationModel.fromJson(
      response.data?['images'] as Map<String, dynamic>? ?? {},
    );
  }
}
