import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/favorite_provider.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoriteListProvider>(
        builder: (context, value, child) {
          final favoriteList = value.favoriteList;

          return favoriteList.isNotEmpty
              ? ListView.builder(
                  itemCount: favoriteList.length,
                  itemBuilder: (context, index) {
                    var restaurant = favoriteList[index];
                    String imageUrl = ApiServices()
                        .getImageUrl(restaurant.pictureId, 'medium');

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
                )
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No favorites list found"),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
