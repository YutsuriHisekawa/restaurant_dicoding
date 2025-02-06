import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';

class CustomerReviews extends StatelessWidget {
  final List<CustomerReview> customerReviews;

  const CustomerReviews({super.key, required this.customerReviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customer Reviews:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: customerReviews
              .map((review) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        review.review,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        review.date,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ))
              .toList(),
        ),
      ],
    );
  }
}
