import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';
import 'package:restaurant_app/screens/detail/customer_review.dart';
import 'package:restaurant_app/screens/detail/restaurant_category.dart';
import 'package:restaurant_app/screens/detail/restaurant_menu.dart';
import 'package:restaurant_app/screens/detail/restaurant_info.dart';

class SliverListWidget extends StatelessWidget {
  final DetailRestaurantResponse restaurant;

  const SliverListWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(
                    '${restaurant.rating}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RestaurantInfo(restaurant: restaurant),
              RestaurantCategories(categories: restaurant.categories),
              RestaurantMenus(menus: restaurant.menus),
              CustomerReviews(customerReviews: restaurant.customerReviews),
            ],
          ),
        ),
      ]),
    );
  }
}
