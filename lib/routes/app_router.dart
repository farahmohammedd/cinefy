import 'package:cinefy_app/features/movies/presentation/screens/favorites_screen.dart';
import 'package:cinefy_app/features/movies/presentation/screens/home_screen.dart';
import 'package:cinefy_app/features/movies/presentation/screens/movie_details_screen.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/favorite', builder: (context, state) => FavoritesScreen()),
    GoRoute(
      path: '/Details/:movieId',
      builder: (context, state) => MovieDetailsScreen(
        movieId: int.parse(state.pathParameters['movieId']!),
      ),
    ),
  ],
);
//pathParameters=هاتلي القيم المتغيرة اللي موجودة في الرابط.
