import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';

class RestaurantInfo extends StatelessWidget {
  final DetailRestaurant restaurant;

  const RestaurantInfo({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Restaurant Address
        Text(
          'Address: ${restaurant.address}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),

        // Restaurant City
        Text(
          'City: ${restaurant.city}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),

        // Restaurant Description
        Text(
          restaurant.description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
