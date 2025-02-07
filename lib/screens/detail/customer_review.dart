import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

class CustomerReviews extends StatelessWidget {
  final List<CustomerReview> customerReviews;

  const CustomerReviews({super.key, required this.customerReviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ulasan Pelanggan',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Column(
          children: customerReviews.map((review) {
            return ListTile(
              title: Text(review.name),
              subtitle: Text(review.review),
              trailing: Text(review.date),
            );
          }).toList(),
        ),
      ],
    );
  }
}
