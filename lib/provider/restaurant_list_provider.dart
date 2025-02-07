import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/model/api_service.dart';

abstract class RestaurantListResultState {}

class RestaurantListNoneState extends RestaurantListResultState {}

class RestaurantListLoadingState extends RestaurantListResultState {}

class RestaurantListErrorState extends RestaurantListResultState {
  final String message;
  RestaurantListErrorState(this.message);
}

class RestaurantListLoadedState extends RestaurantListResultState {
  final List<Restaurant> restaurants;
  RestaurantListLoadedState(this.restaurants);
}

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  RestaurantListProvider(this._apiServices);

  RestaurantListResultState _resultState = RestaurantListNoneState();
  RestaurantListResultState get resultState => _resultState;

  final List<DetailRestaurantResponse> _favoriteList = [];
  List<DetailRestaurantResponse> get favoriteList => _favoriteList;

  List<Restaurant> _restaurants = [];
  List<Restaurant> _searchResults = [];
  List<Restaurant> get searchResults => _searchResults;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();
      final result = await _apiServices.getRestaurantList();
      if (result.restaurants.isEmpty) {
        _resultState = RestaurantListErrorState("No restaurants found.");
      } else {
        _restaurants = result.restaurants;
        _resultState = RestaurantListLoadedState(_restaurants);
      }
    } catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
    }
    notifyListeners();
  }

  void toggleFavorite(DetailRestaurantResponse restaurant) {
    if (isFavorite(restaurant)) {
      removeFavorite(restaurant);
    } else {
      _favoriteList.add(restaurant);
    }
    notifyListeners();
  }

  void removeFavorite(DetailRestaurantResponse restaurant) {
    _favoriteList.removeWhere((item) => item.id == restaurant.id);
    notifyListeners();
  }

  bool isFavorite(DetailRestaurantResponse restaurant) {
    return _favoriteList.any((item) => item.id == restaurant.id);
  }

  Future<void> searchRestaurants(String query) async {
    try {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        final result = await _apiServices.searchRestaurant(query);
        _searchResults = result.restaurants;
      }
    } catch (e) {
      _searchResults = [];
    }
    notifyListeners();
  }
}
