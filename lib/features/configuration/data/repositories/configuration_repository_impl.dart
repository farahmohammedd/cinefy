import '../../domain/entities/configuration.dart';
import '../../domain/repositories/configuration_repository.dart';
import '../datasources/configuration_remote_data_source.dart';

class ConfigurationRepositoryImpl implements ConfigurationRepository {
  final ConfigurationRemoteDataSource remoteDataSource;

  ConfigurationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Configuration> getConfiguration() async {
    final configurationModel = await remoteDataSource.getConfiguration();

    return configurationModel.toEntity();
  }
}
