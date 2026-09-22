import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'features/movies/data/models/movie_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieModelAdapter());
  await Hive.openBox<MovieModel>('favoritesBox');
  await Hive.openBox<MovieModel>('moviesCacheBox');
  await Hive.openBox<MovieModel>('topRatedCacheBox');

  await dotenv.load(fileName: '.env');

  runApp(const ProviderScope(child: MyApp()));
}
