import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

sealed class RestaurantDetailState {}

class RestaurantDetailInitial extends RestaurantDetailState {}

class RestaurantDetailLoading extends RestaurantDetailState {}

class RestaurantDetailLoaded extends RestaurantDetailState {
  final DetailRestaurantResponse restaurant;
  RestaurantDetailLoaded(this.restaurant);
}

class RestaurantDetailError extends RestaurantDetailState {
  final String message;
  RestaurantDetailError(this.message);
}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  RestaurantDetailProvider(this._apiServices);

  RestaurantDetailState _state = RestaurantDetailInitial();
  RestaurantDetailState get state => _state;

  bool _isDescriptionExpanded = false;
  bool get isDescriptionExpanded => _isDescriptionExpanded;

  bool _showFoods = false;
  bool get showFoods => _showFoods;

  bool _showDrinks = false;
  bool get showDrinks => _showDrinks;

  Future<void> fetchRestaurantDetail(String restaurantId) async {
    if (_state is RestaurantDetailLoading || _state is RestaurantDetailLoaded) {
      return;
    }

    _state = RestaurantDetailLoading();
    notifyListeners();

    try {
      final restaurant = await _apiServices.getRestaurantDetails(restaurantId);
      _state = RestaurantDetailLoaded(restaurant);
    } on SocketException {
      _state = RestaurantDetailError(
          "Koneksi Internet Anda terputus. Periksa koneksi Anda.");
    } on HttpException {
      _state = RestaurantDetailError("Kesalahan HTTP: Gagal mengambil data.");
    } catch (e) {
      _state = RestaurantDetailError("Terjadi kesalahan: ${e.toString()}");
    }

    notifyListeners();
  }

  void toggleDescription() {
    _isDescriptionExpanded = !_isDescriptionExpanded;
    notifyListeners();
  }

  void toggleFoods() {
    _showFoods = !_showFoods;
    notifyListeners();
  }

  void toggleDrinks() {
    _showDrinks = !_showDrinks;
    notifyListeners();
  }
}
