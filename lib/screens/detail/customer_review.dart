import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/widgets/lottie/lottie_loading.dart';

class CustomerReviews extends StatefulWidget {
  final List<CustomerReview> customerReviews;
  final String restaurantId;

  const CustomerReviews(
      {super.key, required this.customerReviews, required this.restaurantId});

  @override
  _CustomerReviewsState createState() => _CustomerReviewsState();
}

class _CustomerReviewsState extends State<CustomerReviews> {
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;

  // Add a new review
  Future<void> _addReview() async {
    if (_reviewController.text.isEmpty || _nameController.text.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true; // Show the loading indicator
    });

    try {
      await ApiServices().postReview(
        widget.restaurantId,
        _nameController.text,
        _reviewController.text,
      );
      _reviewController.clear();
      _nameController.clear();

      // After submitting, fetch the updated list of reviews
      await _fetchReviews();
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add review: $e")),
      );
    }
  }

  // Fetch updated reviews after adding a new one
  Future<void> _fetchReviews() async {
    try {
      final updatedReviews =
          await ApiServices().getRestaurantDetails(widget.restaurantId);
      setState(() {
        widget.customerReviews.clear();
        widget.customerReviews
            .addAll(updatedReviews.restaurant.customerReviews);
        isLoading = false; // Hide the loading indicator
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Hide the loading indicator if error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch updated reviews: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort reviews by date, placing the latest first
    List<CustomerReview> sortedReviews = List.from(widget.customerReviews)
      ..sort((a, b) => b.date.compareTo(a.date));

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
            // Review input form
            Text(
              '💬 Tambahkan Ulasan',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Anda',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reviewController,
              decoration: const InputDecoration(
                labelText: 'Tulis Ulasan',
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addReview,
              child: const Text('Kirim Ulasan'),
            ),
            const SizedBox(height: 24), // Space between review input and list
            // Show loading indicator while submitting and fetching reviews
            if (isLoading) const LottieLoading(), // Lottie loading animation
            // Displaying sorted reviews
            if (!isLoading) ...[
              Text(
                '📋 Ulasan Pelanggan',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sortedReviews.map((review) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              review.review,
                              style: const TextStyle(fontSize: 14),
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
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
