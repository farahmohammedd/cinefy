import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cinefy_app/features/movies/domain/entities/movie.dart';
import 'package:cinefy_app/features/configuration/presentation/image_service.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
    required this.imageService,
    this.width = 140,
  });

  final Movie movie;
  final ImageService imageService;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/Details/${movie.id}');
      },
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 105,
                height: 150,
                child: movie.posterPath == null || movie.posterPath!.isEmpty
                    ? const Icon(Icons.movie)
                    : Image.network(
                        imageService.getPosterUrl(
                          size: 'w342',
                          posterPath: movie.posterPath!,
                        ),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.movie);
                        },
                      ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
