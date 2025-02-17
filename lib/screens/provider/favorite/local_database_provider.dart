import 'package:flutter/material.dart';
import 'package:restaurant_app/data/local_database_service.dart';
import 'package:restaurant_app/model/restaurant.dart';

class LocalDatabaseProvider with ChangeNotifier {
  final LocalDatabaseService _service;

  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<Restaurant> _favoriteList = [];
  List<Restaurant> get favoriteList => _favoriteList;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  get state => null;

  bool get isNotEmpty => _favoriteList.isNotEmpty;
  bool get isEmpty => _favoriteList.isEmpty;

  Future<void> loadAllRestaurants() async {
    try {
      _favoriteList = await _service.getAllItems();
      print("Loaded restaurants: $_favoriteList");
      if (_favoriteList.isEmpty) {
        _message = "Tidak ada restoran favorit untuk dimuat.";
        print("No favorite restaurants found.");
      } else {
        _message = "Data restoran favorit berhasil dimuat.";
      }
    } catch (e) {
      _message = "Gagal memuat data restoran favorit.";
      print("Error loading favorite restaurants: $e");
    }
    notifyListeners();
  }

  Future<void> saveRestaurant(Restaurant restaurant) async {
    try {
      final result = await _service.insertItem(restaurant);
      if (result == 0) {
        _message = "Gagal menyimpan restoran ke favorit.";
        print("Error saving restaurant: ${restaurant.name}, result was 0");
      } else {
        _message = "Restoran berhasil ditambahkan ke favorit.";
        print("Saved restaurant: ${restaurant.name}, Result: $result");
      }
      await loadAllRestaurants();
    } catch (e) {
      _message = "Gagal menyimpan restoran ke favorit.";
      print("Error saving restaurant: $e");
    }
    notifyListeners();
  }

  Future<void> removeRestaurantById(String id) async {
    try {
      final result = await _service.removeItem(id);
      if (result == 0) {
        _message = "Gagal menghapus restoran dari favorit.";
        print("Error removing restaurant with ID: $id, result was 0");
      } else {
        _message = "Restoran berhasil dihapus dari favorit.";
        print("Removed restaurant with ID: $id");
      }
      await loadAllRestaurants();
    } catch (e) {
      _message = "Gagal menghapus restoran dari favorit.";
      print("Error removing restaurant: $e");
    }
    notifyListeners();
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
      if (_restaurant == null) {
        _message = "Restoran dengan ID $id tidak ditemukan.";
        print("No restaurant found with ID: $id");
      } else {
        _message = "Restoran berhasil dimuat.";
        print("Loaded restaurant: $_restaurant");
      }
    } catch (e) {
      _message = "Gagal memuat data restoran.";
      print("Error loading restaurant by ID: $e");
    }
    notifyListeners();
  }

  bool isRestaurantFavorite(String id) {
    return _favoriteList.any((restaurant) => restaurant.id == id);
  }
}
