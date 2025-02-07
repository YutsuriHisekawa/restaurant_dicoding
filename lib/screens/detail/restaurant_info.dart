import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

class RestaurantInfo extends StatelessWidget {
  final DetailRestaurantResponse restaurant;

  const RestaurantInfo({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi Restoran',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Alamat: ${restaurant.address}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          'Kota: ${restaurant.city}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          'Deskripsi: ${restaurant.description}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
