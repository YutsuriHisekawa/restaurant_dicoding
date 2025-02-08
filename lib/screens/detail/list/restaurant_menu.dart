import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, provider, child) {
            return Column(
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
                _buildExpandableSection(
                  title: '🍔 Makanan',
                  isExpanded: provider.showFoods,
                  onTap: provider.toggleFoods,
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
                _buildExpandableSection(
                  title: '🥤 Minuman',
                  isExpanded: provider.showDrinks,
                  onTap: provider.toggleDrinks,
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              const Spacer(),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.deepOrange,
              ),
            ],
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: children,
            ),
          ),
      ],
    );
  }
}
