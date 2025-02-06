import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/detail/body_detail.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String restaurantId =
        ModalRoute.of(context)?.settings.arguments as String;
    return FutureBuilder<DetailRestaurant>(
      future: ApiServices().getRestaurantDetails(restaurantId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('No restaurant details found.')),
          );
        }

        var restaurant = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(restaurant.name),
          ),
          body: BodyDetail(restaurantId: restaurantId),
        );
      },
    );
  }
}
