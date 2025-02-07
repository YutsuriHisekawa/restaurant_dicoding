import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/detail/favorite_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final Restaurant restaurant;

  const FavoriteIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    final favoriteListProvider = context.read<FavoriteListProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() {
      final restaurantInList =
          favoriteListProvider.checkItemFavorite(widget.restaurant);
      favoriteIconProvider.isFavorite = restaurantInList;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final favoriteListProvider = context.read<FavoriteListProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorite = favoriteIconProvider.isFavorite;

        if (!isFavorite) {
          favoriteListProvider.addFavorite(widget.restaurant);
        } else {
          favoriteListProvider.removeFavorite(widget.restaurant);
        }

        favoriteIconProvider.isFavorite = !isFavorite;
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
          color: context.watch<FavoriteIconProvider>().isFavorite
              ? Colors.red
              : const Color.fromARGB(255, 167, 167, 167),
          size: 30.0,
        ),
      ),
    );
  }
}
