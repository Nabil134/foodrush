import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Shimmer.fromColors(
      baseColor: colorScheme.onSurfaceVariant.withOpacity(0.5),
      highlightColor: colorScheme.surface,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}