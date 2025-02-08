import 'package:flutter/material.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

sealed class ReviewState {
  const ReviewState();
}

final class ReviewInitialState extends ReviewState {
  const ReviewInitialState();
}

final class ReviewLoadingState extends ReviewState {
  const ReviewLoadingState();
}

final class ReviewErrorState extends ReviewState {
  final String message;
  const ReviewErrorState(this.message);
}

final class ReviewLoadedState extends ReviewState {
  final List<CustomerReview> reviews;
  const ReviewLoadedState(this.reviews);
}

final class ReviewSubmittingState extends ReviewState {
  const ReviewSubmittingState();
}

class ReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final String restaurantId;

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  ReviewState _state = const ReviewInitialState();
  ReviewState get state => _state;

  ReviewProvider(this._apiServices, this.restaurantId);

  bool? get isSubmitting => null;

  Future<void> fetchReviews() async {
    _state = const ReviewLoadingState();
    notifyListeners();

    try {
      final response = await _apiServices.getRestaurantDetails(restaurantId);
      _state = ReviewLoadedState(response.restaurant.customerReviews);
    } catch (e) {
      _state = const ReviewErrorState("Gagal mengambil ulasan.");
    }
    notifyListeners();
  }

  Future<void> addReview(String name, String reviewText) async {
    if (name.isEmpty || reviewText.isEmpty) {
      _state = const ReviewErrorState("Nama dan ulasan wajib diisi!");
      notifyListeners();
      return;
    }

    _state = const ReviewSubmittingState();
    notifyListeners();

    try {
      await _apiServices.postReview(restaurantId, name, reviewText);
      await fetchReviews();
      nameController.clear();
      reviewController.clear();
    } catch (e) {
      _state = const ReviewErrorState("Gagal mengirim ulasan.");
    }
    notifyListeners();
  }
}
