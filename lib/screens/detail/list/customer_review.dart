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
                if (provider.state is ReviewLoadingState) {
                  return const LottieLoading();
                }
                if (provider.state is ReviewErrorState) {
                  return Center(
                    child: Text(
                      (provider.state as ReviewErrorState).message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (provider.state is ReviewLoadedState) {
                  final reviews = (provider.state as ReviewLoadedState)
                      .reviews
                      .reversed
                      .toList();

                  if (reviews.isEmpty) {
                    return const Center(
                      child: Text(
                        'Belum ada ulasan.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      ...reviews.take(provider.displayedReviews).map((review) {
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Colors.deepOrange.withOpacity(0.2),
                                child: Text(
                                  review.name[0].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                review.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    review.review,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
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
                          ),
                        );
                      }),
                      if (provider.displayedReviews < reviews.length)
                        Center(
                          child: ElevatedButton(
                            onPressed: () => provider.loadMoreReviews(reviews),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              'Muat Lebih Banyak',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
