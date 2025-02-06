import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';

class RestaurantMenus extends StatelessWidget {
  final Menus menus;

  const RestaurantMenus({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Menus:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Foods:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: menus.foods.map((food) => Text('- ${food.name}')).toList(),
        ),
        const SizedBox(height: 8),
        const Text(
          'Drinks:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              menus.drinks.map((drink) => Text('- ${drink.name}')).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
