import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

class RestaurantMenus extends StatelessWidget {
  final Menus menus;

  const RestaurantMenus({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🍴 Menu',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
            ),
            const SizedBox(height: 12),
            const Text(
              '🍔 Foods:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: menus.foods.map((food) {
                return Chip(
                  label: Text(
                    food.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              '🥤 Drinks:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: menus.drinks.map((drink) {
                return Chip(
                  label: Text(
                    drink.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
