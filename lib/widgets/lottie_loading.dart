import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoading extends StatelessWidget {
  final double width;
  final double height;

  const LottieLoading({super.key, this.width = 200, this.height = 200});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/loading.json',
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}
