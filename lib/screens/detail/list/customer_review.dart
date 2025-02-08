import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/provider/detail/review_provider.dart';
import 'package:restaurant_app/screens/detail/list/field_review_detail.dart';
import 'package:restaurant_app/widgets/lottie/lottie_loading.dart';

class CustomerReviews extends StatelessWidget {
  final String restaurantId;
  const CustomerReviews({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ReviewProvider(ApiServices(), restaurantId)..fetchReviews(),
      child: const _CustomerReviewsContent(),
    );
  }
}

class _CustomerReviewsContent extends StatelessWidget {
  const _CustomerReviewsContent();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FieldReviewDetail(),
            const SizedBox(height: 24),
            Consumer<ReviewProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const LottieLoading();
                }
                return Column(
                  children: provider.reviews.reversed.map((review) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(review.review),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                review.date,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
