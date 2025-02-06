import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_list_response.dart';
import 'package:restaurant_app/screens/detail/body_detail.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the restaurant data passed as arguments
    final Restaurant restaurant =
        ModalRoute.of(context)?.settings.arguments as Restaurant;

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: BodyDetail(restaurant: restaurant),
    );
  }
}
