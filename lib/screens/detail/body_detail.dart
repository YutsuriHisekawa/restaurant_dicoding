import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/detail/sliver/sliver_list.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';
import 'package:restaurant_app/widgets/lottie_loading.dart';

class BodyDetail extends StatefulWidget {
  final String restaurantId;

  const BodyDetail({super.key, required this.restaurantId});

  @override
  _BodyDetailState createState() => _BodyDetailState();
}

class _BodyDetailState extends State<BodyDetail> {
  late Future<DetailRestaurant> _restaurantDetail;

  @override
  void initState() {
    super.initState();
    _fetchRestaurantDetail();
  }

  void _fetchRestaurantDetail() {
    setState(() {
      _restaurantDetail =
          ApiServices().getRestaurantDetails(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder<DetailRestaurant>(
        future: _restaurantDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LottieLoading();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No restaurant details found.'));
          } else {
            var restaurant = snapshot.data!;

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
            );
          }
        },
      ),
    );
  }
}
