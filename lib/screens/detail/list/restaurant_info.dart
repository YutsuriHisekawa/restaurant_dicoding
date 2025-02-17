import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';
import 'package:restaurant_app/screens/provider/detail/restaurant_detail_provider.dart';

class RestaurantInfo extends StatelessWidget {
  final DetailRestaurantResponse restaurant;

  const RestaurantInfo({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, provider, child) {
            final description = restaurant.description;
            final isLongDescription = description.length > 200;
            final displayDescription = provider.isDescriptionExpanded
                ? description
                : (isLongDescription
                    ? '${description.substring(0, 200)}...'
                    : description);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📍 Informasi Restoran',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                ),
                const SizedBox(height: 12),
                _infoRow(Icons.location_on, 'Alamat', restaurant.address),
                _infoRow(Icons.location_city, 'Kota', restaurant.city),
                _infoRow(Icons.description, 'Deskripsi', displayDescription),
                if (isLongDescription)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: provider.toggleDescription,
                      child: Text(
                        provider.isDescriptionExpanded
                            ? 'Tutup'
                            : 'Baca selengkapnya',
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.deepOrange, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
