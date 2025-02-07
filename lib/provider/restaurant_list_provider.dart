import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/model/api_service.dart';

/// Definisikan state untuk hasil restoran
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

  // Menyimpan state restoran
  RestaurantListResultState get resultState => _resultState;

  // Daftar favorit restoran
  List<DetailRestaurantResponse> _favoriteList = [];

  List<DetailRestaurantResponse> get favoriteList => _favoriteList;

  // Method untuk mengambil daftar restoran
  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      // Mengambil data restoran melalui API
      final result = await _apiServices.getRestaurantList();

      if (result.restaurants.isEmpty) {
        _resultState = RestaurantListErrorState("No restaurants found.");
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
      }
    } catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
    }
    notifyListeners();
  }

  void toggleFavorite(DetailRestaurantResponse restaurant) {
    if (_favoriteList.contains(restaurant)) {
      _favoriteList.remove(restaurant); // Jika sudah ada, hapus
    } else {
      _favoriteList.add(restaurant); // Jika belum ada, tambahkan
    }
    notifyListeners(); // Memberitahukan listener untuk update UI
  }

  void removeFavorite(DetailRestaurantResponse restaurant) {}
}
