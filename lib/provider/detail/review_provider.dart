import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

class ReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  final String restaurantId;

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  ReviewProvider(this._apiServices, this.restaurantId);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

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
    } on SocketException {
      _errorMessage = "Koneksi Internet anda telah terputus.";
    } on HttpException catch (e) {
      _errorMessage = "HTTP Error: ${e.message}";
    } catch (e) {
      _errorMessage = "Gagal mengambil ulasan: ${e.toString()}";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addReview(String name, String reviewText) async {
    if (name.isEmpty || reviewText.isEmpty) {
      _errorMessage = "Nama dan ulasan tidak boleh kosong.";
      notifyListeners();
      return;
    }

    _isSubmitting = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _apiServices.postReview(restaurantId, name, reviewText);
      await fetchReviews();
      clearControllers();
    } on SocketException {
      _errorMessage = "Koneksi Internet anda telah terputus.";
    } on HttpException catch (e) {
      _errorMessage = "HTTP Error: ${e.message}";
    } catch (e) {
      _errorMessage = "Gagal mengirim ulasan: ${e.toString()}";
    }

    _isSubmitting = false;
    notifyListeners();
  }

  void clearControllers() {
    nameController.clear();
    reviewController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    super.dispose();
  }
}
