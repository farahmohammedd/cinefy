import 'package:dio/dio.dart';

import '../core/network/dio_client.dart';

// Movies
import '../features/movies/data/datasources/movie_remote_data_source.dart';
import '../features/movies/data/repositories/movie_repository_impl.dart';
import '../features/movies/domain/repositories/movie_repository.dart';

// Configuration
import '../features/configuration/data/datasources/configuration_remote_data_source.dart';
import '../features/configuration/data/repositories/configuration_repository_impl.dart';
import '../features/configuration/domain/repositories/configuration_repository.dart';
import '../features/configuration/domain/usecases/get_configuration.dart';

final Dio dioClient = dio;

// Movies dependencies
final MovieRemoteDataSource movieRemoteDataSource = MovieRemoteDataSourceImpl(
  dioClient,
);

final MovieRepository movieRepository = MovieRepositoryImpl(
  movieRemoteDataSource,
);

// Configuration dependencies
final ConfigurationRemoteDataSource configurationRemoteDataSource =
    ConfigurationRemoteDataSourceImpl(dioClient);

final ConfigurationRepository configurationRepository =
    ConfigurationRepositoryImpl(configurationRemoteDataSource);

final GetConfiguration getConfiguration = GetConfiguration(
  configurationRepository,
);
