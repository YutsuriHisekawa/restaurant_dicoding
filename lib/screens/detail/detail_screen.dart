import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/screens/detail/body_detail.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';
import 'package:restaurant_app/screens/error/error_screen.dart';
import 'package:restaurant_app/widgets/favorite_icon_widget.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final String restaurantId =
        ModalRoute.of(context)?.settings.arguments as String;

    return FutureBuilder<DetailRestaurantResponse>(
      future: ApiServices().getRestaurantDetails(restaurantId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: ErrorScreen(
              onRetry: () => setState(() {}),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('No restaurant details found.')),
          );
        }

        var restaurantResponse = snapshot.data!;
        var restaurantDetail = restaurantResponse.restaurant;

        var restaurant = Restaurant(
          id: restaurantDetail.id,
          name: restaurantDetail.name,
          city: restaurantDetail.city,
          rating: restaurantDetail.rating,
          pictureId: restaurantDetail.pictureId,
        );

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(restaurantDetail.name),
          ),
          body: Stack(
            children: [
              BodyDetail(restaurantId: restaurantId),
              Positioned(
                right: 20.0,
                bottom: 20.0,
                child: ChangeNotifierProvider(
                  create: (_) => FavoriteIconProvider(),
                  child: FavoriteIconWidget(restaurant: restaurant),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
