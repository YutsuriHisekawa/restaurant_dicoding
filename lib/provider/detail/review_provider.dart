import 'package:flutter/material.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

class ReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final String restaurantId;

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  bool _isSubmitting = false;
  String _errorMessage = "";
  List<CustomerReview> _reviews = [];

  bool get isSubmitting => _isSubmitting;
  String get errorMessage => _errorMessage;
  List<CustomerReview> get reviews => _reviews;
  bool get isLoading => _reviews.isEmpty && !_isSubmitting;

  ReviewProvider(this._apiServices, this.restaurantId);

  Future<void> fetchReviews() async {
    try {
      final response = await _apiServices.getRestaurantDetails(restaurantId);
      _reviews = response.restaurant.customerReviews;
    } catch (e) {
      _errorMessage = "Gagal mengambil ulasan.";
    }
    notifyListeners();
  }

  Future<void> addReview(String name, String reviewText) async {
    if (name.isEmpty || reviewText.isEmpty) {
      _errorMessage = "Nama dan ulasan wajib diisi!";
      notifyListeners();
      return;
    }

    _isSubmitting = true;
    notifyListeners();

    try {
      await _apiServices.postReview(restaurantId, name, reviewText);
      await fetchReviews();
      nameController.clear();
      reviewController.clear();
    } catch (e) {
      _errorMessage = "Gagal mengirim ulasan.";
    }

    _isSubmitting = false;
    notifyListeners();
  }
}
