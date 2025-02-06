import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_list_response.dart';
import 'package:restaurant_app/services/api_service.dart';

class BodyDetail extends StatelessWidget {
  final Restaurant restaurant;

  const BodyDetail({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        ApiServices().getImageUrl(restaurant.pictureId, 'large');

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              restaurant.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${restaurant.city}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange),
                Text('${restaurant.rating}',
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              restaurant.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
