import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';
import 'package:restaurant_app/screens/detail/list/restaurant_category.dart';
import 'package:restaurant_app/screens/detail/list/restaurant_menu.dart';
import 'package:restaurant_app/screens/detail/list/restaurant_info.dart';
import 'package:restaurant_app/screens/detail/list/restaurant_header.dart';
import 'package:restaurant_app/screens/detail/list/customer_review.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/provider/detail/restaurant_detail_provider.dart';

class SliverListWidget extends StatelessWidget {
  final DetailRestaurantResponse restaurant;

  const SliverListWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, provider, child) {
        return SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RestaurantHeader(restaurant: restaurant),
                  const SizedBox(height: 20),
                  RestaurantInfo(restaurant: restaurant),
                  const SizedBox(height: 20),
                  RestaurantCategories(categories: restaurant.categories),
                  const SizedBox(height: 20),
                  RestaurantMenus(menus: restaurant.menus),
                  const SizedBox(height: 20),
                  CustomerReviews(
                    restaurantId: restaurant.id,
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
