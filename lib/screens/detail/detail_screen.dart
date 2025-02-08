import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/detail/body_detail.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String restaurantId = arguments['id'] ?? '';

    return Scaffold(
      body: BodyDetail(restaurantId: restaurantId),
    );
  }
}
