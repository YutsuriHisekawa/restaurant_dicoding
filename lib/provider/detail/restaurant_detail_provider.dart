import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/api_service.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(this._apiServices);

  DetailRestaurantResponse? _restaurantDetail;
  DetailRestaurantResponse? get restaurantDetail => _restaurantDetail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchRestaurantDetail(String restaurantId) async {
    if (_isLoading || _restaurantDetail != null) return;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _restaurantDetail = await _apiServices.getRestaurantDetails(restaurantId);
    } on SocketException {
      _errorMessage =
          "Koneksi Internet Anda telah terputus. Periksa koneksi Anda.";
    } on HttpException {
      _errorMessage = "Kesalahan HTTP: Gagal mengambil data.";
    } catch (e) {
      _errorMessage = "Terjadi kesalahan: ${e.toString()}";
    }

    _isLoading = false;
    notifyListeners();
  }
}
