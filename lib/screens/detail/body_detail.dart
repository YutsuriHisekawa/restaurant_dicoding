import 'package:flutter/material.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screens/detail/list/sliver_list.dart';
import 'package:restaurant_app/widgets/shimer/shimer_loading.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/error/error_screen.dart';
import 'package:restaurant_app/widgets/favorite_icon_widget.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/model/restaurant.dart';

class BodyDetail extends StatefulWidget {
  final String restaurantId;

  const BodyDetail({super.key, required this.restaurantId});

  @override
  _BodyDetailState createState() => _BodyDetailState();
}

class _BodyDetailState extends State<BodyDetail> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(ApiServices())
        ..fetchRestaurantDetail(widget.restaurantId),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const ShimmerLoading();
          }

          if (provider.errorMessage.isNotEmpty) {
            return ErrorScreen(
              onRetry: () {
                context
                    .read<RestaurantDetailProvider>()
                    .fetchRestaurantDetail(widget.restaurantId);
              },
              errorMessage: provider.errorMessage,
            );
          }

          final restaurant = provider.restaurantDetail;

          if (restaurant == null) {
            return const Center(child: Text('No restaurant details found.'));
          }

          var restaurantModel = Restaurant(
            id: restaurant.id,
            name: restaurant.name,
            city: restaurant.city,
            rating: restaurant.rating,
            pictureId: restaurant.pictureId,
          );

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300,
                    automaticallyImplyLeading: false,
                    pinned: false,
                    floating: false,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: 'restaurant-${restaurant.id}',
                        child: Image.network(
                          ApiServices()
                              .getImageUrl(restaurant.pictureId, 'large'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SliverListWidget(restaurant: restaurant),
                ],
              ),
              Positioned(
                right: 20.0,
                bottom: 20.0,
                child: ChangeNotifierProvider(
                  create: (_) => FavoriteIconProvider(),
                  child: FavoriteIconWidget(restaurant: restaurantModel),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
