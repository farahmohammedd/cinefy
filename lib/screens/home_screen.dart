import 'package:cinefy_app/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinefy_app/providers/movie_provider.dart';
import 'package:cinefy_app/widgets/home_loading_shimmer.dart';
import 'package:cinefy_app/widgets/error_state.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final imageServiceState = ref.watch(imageServiceProvider);
    final moviesState = ref.watch(moviesProvider);
    final topRatedState = ref.watch(topRatedMoviesProvider);

    return imageServiceState.when(
      loading: () {
        return const HomeLoadingShimmer();
      },

      data: (imageService) {
        return Scaffold(
          appBar: AppBar(title: const Text('Cinefy')),

          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SearchBar(
                  hintText: 'Search for your movies',
                  onChanged: (query) {
                    setState(() {
                      isSearching = query.isNotEmpty;
                    });
                    if (query.isEmpty) {
                      ref.read(moviesProvider.notifier).loadMovies();
                    } else {
                      ref.read(moviesProvider.notifier).searchMovies(query);
                    }
                  },
                ),
              ),

              Expanded(
                child: moviesState.when(
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },

                  data: (movies) {
                    if (isSearching && movies.isEmpty) {
                      return const Center(
                        child: Text('No movies found for your search'),
                      );
                    }

                    if (isSearching) {
                      return GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.5,
                        children: movies.map((movie) {
                          return MovieCard(
                            movie: movie,
                            imageService: imageService,
                            width: double.infinity,
                          );
                        }).toList(),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: PageView(
                              children: movies.take(3).map((movie) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        imageService.getPosterUrl(
                                          size: 'w780',
                                          posterPath: movie.backdropPath,
                                        ),
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),

                                      Positioned(
                                        left: 20,
                                        right: 20,
                                        bottom: 35,
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.8),
                                                Colors.transparent,
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                movie.title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.2,
                                                ),
                                              ),

                                              const SizedBox(height: 12),

                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    context.push(
                                                      '/Details/${movie.id}',
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 18,
                                                          vertical: 12,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'View Details',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 10,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          spacing: 8,
                                          children: List.generate(
                                            3,
                                            (index) => Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: index == currentIndex
                                                    ? const Color.fromARGB(
                                                        255,
                                                        10,
                                                        11,
                                                        12,
                                                      )
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),

                              onPageChanged: (value) {
                                setState(() {
                                  currentIndex = value;
                                });
                              },
                            ),
                          ),

                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'Popular Movies',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 210,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: movies.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 8);
                              },
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                return MovieCard(
                                  movie: movie,
                                  imageService: imageService,
                                );
                              },
                            ),
                          ),

                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'Top Rated Movies',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          topRatedState.when(
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            data: (topRatedMovies) => SizedBox(
                              height: 210,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: topRatedMovies.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 8);
                                },
                                itemBuilder: (context, index) {
                                  final movie = topRatedMovies[index];
                                  return MovieCard(
                                    movie: movie,
                                    imageService: imageService,
                                  );
                                },
                              ),
                            ),
                            error: (error, stackTrace) {
                              return ErrorState(
                                message: 'Failed to load top rated movies',
                                onRetry: () {
                                  ref
                                      .read(topRatedMoviesProvider.notifier)
                                      .loadTopRatedMovies();
                                },
                              );
                            },
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'Movies',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.55,
                            children: movies.map((movie) {
                              return MovieCard(
                                movie: movie,
                                imageService: imageService,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },

                  error: (error, stackTrace) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 50),
                            const SizedBox(height: 16),
                            const Text(
                              'Something went wrong',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Please check your internet connection.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
            onTap: (value) {
              if (value == 0) {
                context.go('/');
              }

              if (value == 1) {
                context.go('/favorite');
              }
            },
          ),
        );
      },

      error: (error, stackTrace) {
        return ErrorState(
          message: 'Something went wrong',
          onRetry: () {
            ref.read(moviesProvider.notifier).loadMovies();
          },
        );
      },
    );
  }
}
