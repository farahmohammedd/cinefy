import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefy_app/injection/injection_container.dart';
import 'package:cinefy_app/features/configuration/domain/entities/configuration.dart';

import 'image_service.dart';

final configurationProvider = FutureProvider<Configuration>((ref) async {
  return getConfiguration();
});

final imageServiceProvider = FutureProvider<ImageService>((ref) async {
  final configuration = await ref.watch(configurationProvider.future);

  return ImageService(configuration: configuration);
});
