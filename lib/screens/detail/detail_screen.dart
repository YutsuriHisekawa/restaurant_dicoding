import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/detail/body_detail.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String restaurantId =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Restaurant Details'),
      ),
      body: BodyDetail(restaurantId: restaurantId),
    );
  }
}
