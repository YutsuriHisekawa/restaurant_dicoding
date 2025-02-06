import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/detail/shimer/shimer_box.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 300,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(widthFactor: 0.5, height: 24),
                  SizedBox(height: 8),
                  ShimmerBox(width: 40, height: 16),
                  SizedBox(height: 16),
                  ShimmerBox(width: double.infinity, height: 80),
                  SizedBox(height: 16),
                  ShimmerBox(width: double.infinity, height: 150),
                  SizedBox(height: 16),
                  ShimmerBox(width: double.infinity, height: 80),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
