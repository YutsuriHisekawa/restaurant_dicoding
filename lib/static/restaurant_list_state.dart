import 'package:flutter/material.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/model/restaurant.dart';

abstract class RestaurantListState {}

class RestaurantListIdle extends RestaurantListState {}

class RestaurantListLoading extends RestaurantListState {}

class RestaurantListCompleteWithError extends RestaurantListState {
  final String errorMessage;

  RestaurantListCompleteWithError(this.errorMessage);
}

class RestaurantListCompleteWithValue extends RestaurantListState {
  final List<Restaurant> restaurants;

  RestaurantListCompleteWithValue(this.restaurants);
}

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantListProvider(this._apiServices);

  RestaurantListState _state = RestaurantListIdle();

  RestaurantListState get state => _state;

  Future<void> fetchRestaurantList() async {
    _state = RestaurantListLoading();
    notifyListeners();

    try {
      final result = await _apiServices.getRestaurantList();

      if (result.restaurants.isEmpty) {
        _state = RestaurantListCompleteWithError('No data found');
      } else {
        _state = RestaurantListCompleteWithValue(result.restaurants);
      }
    } catch (e) {
      _state = RestaurantListCompleteWithError('Failed to fetch data: $e');
    }

    notifyListeners();
  }
}
