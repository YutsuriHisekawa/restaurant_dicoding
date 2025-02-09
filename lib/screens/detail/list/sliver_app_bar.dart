import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/model/api_service.dart';

class CustomSliverAppBar extends StatelessWidget {
  final Restaurant restaurant;

  const CustomSliverAppBar({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      floating: false,
      backgroundColor: Colors.deepOrange,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
        color: Colors.white,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'restaurant-${restaurant.id}',
          child: Image.network(
            ApiServices().getImageUrl(restaurant.pictureId, 'large'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        title: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              restaurant.name,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.black54,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
        titlePadding: const EdgeInsets.only(bottom: 16, right: 16),
      ),
    );
  }
}
