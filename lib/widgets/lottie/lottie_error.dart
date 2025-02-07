import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieError extends StatelessWidget {
  const LottieError({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/error.json',
      width: 250,
      height: 250,
      fit: BoxFit.contain,
    );
  }
}
