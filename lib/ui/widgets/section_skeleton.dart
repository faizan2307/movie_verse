import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalCardsSkeleton extends StatelessWidget {
  final int itemCount;
  const HorizontalCardsSkeleton({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, __) => _card(),
      ),
    );
  }

  Widget _card() {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Shimmer.fromColors(
              baseColor: Colors.black12,
              highlightColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: const ColoredBox(color: Colors.black12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: Colors.white,
            child: Container(height: 16, width: 120, color: Colors.black12),
          ),
        ],
      ),
    );
  }
}


