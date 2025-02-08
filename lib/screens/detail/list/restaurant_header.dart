import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

class RestaurantHeader extends StatelessWidget {
  final DetailRestaurantResponse restaurant;

  const RestaurantHeader({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            restaurant.name,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.deepOrange.withAlpha(77),
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: Colors.white, size: 18),
              const SizedBox(width: 4),
              Text(
                '${restaurant.rating}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
