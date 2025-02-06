import 'package:flutter/material.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/model/restaurant_list_response.dart';

class DetailImage extends StatelessWidget {
  final Restaurant restaurant;

  const DetailImage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        ApiServices().getImageUrl(restaurant.pictureId, 'large');

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Hero(
                  tag: 'restaurant-${restaurant.id}',
                  child: Center(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.8,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Hero(
        tag: 'restaurant-${restaurant.id}',
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: 250,
          width: double.infinity,
        ),
      ),
    );
  }
}
