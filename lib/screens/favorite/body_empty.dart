import 'package:flutter/material.dart';

class BodyEmpty extends StatelessWidget {
  const BodyEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "Favorite Tidak Tersedia!",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Tambahkan Restaurant Favorite mu!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
