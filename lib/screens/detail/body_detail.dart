import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screens/detail/sliver/sliver_list.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/widgets/shimer/shimer_loading.dart';
import 'package:provider/provider.dart';

class BodyDetail extends StatefulWidget {
  final String restaurantId;

  const BodyDetail({super.key, required this.restaurantId});

  @override
  _BodyDetailState createState() => _BodyDetailState();
}

class _BodyDetailState extends State<BodyDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const ShimmerLoading();
        }

        if (provider.errorMessage.isNotEmpty) {
          return Center(child: Text(provider.errorMessage));
        }

        final restaurant = provider.restaurantDetail;

        if (restaurant == null) {
          return const Center(child: Text('No restaurant details found.'));
        }

        return CustomScrollView(
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
                    ApiServices().getImageUrl(restaurant.pictureId, 'large'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverListWidget(restaurant: restaurant),
          ],
        );
      },
    );
  }
}
