import 'package:flutter/material.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class SearchList extends StatelessWidget {
  final List<Restaurant> searchResults;

  const SearchList({super.key, required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        var restaurant = searchResults[index];
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
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 80),
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
