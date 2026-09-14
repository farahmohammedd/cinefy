import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/movie.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('favoritesBox');
  await Hive.openBox<Movie>('moviesCacheBox');
  await Hive.openBox<Movie>('topRatedCacheBox');

  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(child: MyApp()));
}
