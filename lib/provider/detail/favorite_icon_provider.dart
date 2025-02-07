import 'package:flutter/material.dart';

class FavoriteIconProvider extends ChangeNotifier {
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
