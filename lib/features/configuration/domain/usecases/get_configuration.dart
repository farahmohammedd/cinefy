import '../entities/configuration.dart';
import '../repositories/configuration_repository.dart';

class GetConfiguration {
  final ConfigurationRepository repository;

  GetConfiguration(this.repository);

  Future<Configuration> call() {
    return repository.getConfiguration();
  }
}
