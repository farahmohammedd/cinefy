import '../entities/configuration.dart';

abstract class ConfigurationRepository {
  Future<Configuration> getConfiguration();
}
