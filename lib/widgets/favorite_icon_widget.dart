import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/restaurant.dart';

import 'package:restaurant_app/screens/provider/favorite/local_database_provider.dart';

class FavoriteIconWidget extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalDatabaseProvider>(
      builder: (context, localDatabaseProvider, _) {
        final isFavorite =
            localDatabaseProvider.isRestaurantFavorite(restaurant.id!);

        return IconButton(
          onPressed: () async {
            if (!isFavorite) {
              await localDatabaseProvider.saveRestaurant(restaurant);
            } else {
              if (restaurant.id != null) {
                await localDatabaseProvider
                    .removeRestaurantById(restaurant.id!);
              }
            }
          },
          icon: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(33, 0, 0, 0),
                  blurRadius: 8.0,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite,
              color: isFavorite
                  ? Colors.red
                  : const Color.fromARGB(255, 167, 167, 167),
              size: 30.0,
            ),
          ),
        );
      },
    );
  }
}
