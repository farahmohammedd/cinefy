import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMovieCard extends StatelessWidget {
  const ShimmerMovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const SizedBox(
                width: 140,
                height: 175,
                child: ColoredBox(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(
              width: 100,
              height: 16,
              child: ColoredBox(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
