import 'package:flutter/material.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

class ReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final String restaurantId;

  // Initialize TextEditingControllers
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  ReviewProvider(this._apiServices, this.restaurantId);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<CustomerReview> _reviews = [];
  List<CustomerReview> get reviews => _reviews;

  Future<void> fetchReviews() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _apiServices.getRestaurantDetails(restaurantId);
      _reviews = response.restaurant.customerReviews;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addReview(String name, String reviewText) async {
    if (name.isEmpty || reviewText.isEmpty) return;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _apiServices.postReview(restaurantId, name, reviewText);
      await fetchReviews();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
