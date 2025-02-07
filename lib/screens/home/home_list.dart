import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class HomeList extends StatelessWidget {
  final List<Restaurant> restaurants;

  const HomeList({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        var restaurant = restaurants[index];
        String imageUrl =
            ApiServices().getImageUrl(restaurant.pictureId, 'medium');

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Hero(
              tag: 'restaurant-${restaurant.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(restaurant.name),
            subtitle: Text(restaurant.city),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.orange),
                Text('${restaurant.rating}'),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                NavigationRoute.detailRoute.name,
                arguments: restaurant.id,
              );
            },
          ),
        );
      },
    );
  }
}
