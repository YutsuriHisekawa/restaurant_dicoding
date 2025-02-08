import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/model/api_service.dart';

/// **State Management untuk Daftar Restoran**
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
        _resultState =
            RestaurantListErrorState("Tidak ada restoran yang ditemukan.");
      } else {
        _restaurants = result.restaurants;
        _resultState = RestaurantListLoadedState(_restaurants);
      }
    } on SocketException {
      _resultState = RestaurantListErrorState(
          "Koneksi Internet Anda telah terputus. Periksa koneksi Anda.");
    } on HttpException {
      _resultState =
          RestaurantListErrorState("Kesalahan HTTP: Gagal mengambil data.");
    } catch (e) {
      _resultState =
          RestaurantListErrorState("Terjadi kesalahan: ${e.toString()}");
    }
    notifyListeners();
  }

  void toggleFavorite(DetailRestaurantResponse restaurant) {
    if (isFavorite(restaurant)) {
      removeFavorite(restaurant);
    } else {
      _favoriteList.add(restaurant);
      notifyListeners();
    }
  }

  void removeFavorite(DetailRestaurantResponse restaurant) {
    _favoriteList.removeWhere((item) => item.id == restaurant.id);
    notifyListeners();
  }

  bool isFavorite(DetailRestaurantResponse restaurant) {
    return _favoriteList.any((item) => item.id == restaurant.id);
  }

  void clearSearchResults() {
    _searchResults = [];
    _resultState = RestaurantListNoneState();
    notifyListeners();
  }

  Future<void> searchRestaurants(String query) async {
    if (query.isEmpty) {
      clearSearchResults();
      return;
    }

    try {
      final result = await _apiServices.searchRestaurant(query);
      if (result.restaurants.isEmpty) {
        _resultState = RestaurantListErrorState("Tidak ada hasil ditemukan.");
      } else {
        _searchResults = result.restaurants;
        _resultState = RestaurantListLoadedState(_searchResults);
      }
    } on SocketException {
      _resultState = RestaurantListErrorState(
          "Kesalahan Jaringan: Periksa koneksi internet Anda.");
    } catch (e) {
      _resultState = RestaurantListErrorState("Kesalahan saat pencarian: $e");
    }
    notifyListeners();
  }
}
