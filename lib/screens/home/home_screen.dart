import 'package:flutter/material.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/model/restaurant_list.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/widgets/lottie_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RestaurantListResponse> _restaurantList;

  @override
  void initState() {
    super.initState();
    _restaurantList = ApiServices().getRestaurantList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<RestaurantListResponse>(
        future: _restaurantList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LottieLoading(); // Gunakan LottieLoading
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.restaurants.isEmpty) {
            return const Center(child: Text('No restaurants found.'));
          } else {
            var restaurants = snapshot.data!.restaurants;
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
        },
      ),
    );
  }
}
