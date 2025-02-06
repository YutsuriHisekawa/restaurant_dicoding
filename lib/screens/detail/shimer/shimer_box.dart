import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double? width;
  final double? widthFactor;
  final double height;

  const ShimmerBox({
    super.key,
    this.width,
    this.widthFactor,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    double finalWidth =
        width ?? MediaQuery.of(context).size.width * (widthFactor ?? 1);

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: finalWidth,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
