import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';

class RestaurantCategories extends StatelessWidget {
  final List<Category> categories;

  const RestaurantCategories({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8,
          children: categories
              .map((category) => Chip(
                    label: Text(category.name),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
