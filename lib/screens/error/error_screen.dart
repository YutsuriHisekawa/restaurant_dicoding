import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/lottie/lottie_error.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onRetry;
  final String errorMessage;

  const ErrorScreen(
      {super.key, required this.onRetry, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    const Color buttonColor = Colors.deepOrange;
    const Color textColor = Colors.white;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LottieError(),
          const SizedBox(height: 20),
          Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: textColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
            child: const Text(
              "Coba Lagi !",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
