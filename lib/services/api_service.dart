import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/restaurant_list.dart';
import 'package:restaurant_app/model/detail_restaurant.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  String getImageUrl(String pictureId, String size) {
    return '$_baseUrl/images/$size/$pictureId';
  }

  // Add function to get restaurant details
  Future<DetailRestaurant> getRestaurantDetails(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant details');
    }
  }
}
