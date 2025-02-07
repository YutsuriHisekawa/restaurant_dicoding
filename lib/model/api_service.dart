import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/restaurant_list_respons.dart';
import 'package:restaurant_app/model/detail_restaurant_respons.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  Future<RestaurantListResponse> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/list"));
      if (response.statusCode == 200) {
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load restaurant list. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load restaurant list: $e');
    }
  }

  String getImageUrl(String pictureId, String size) {
    return '$_baseUrl/images/$size/$pictureId';
  }

  Future<DetailRestaurantResponse> getRestaurantDetails(String id) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

      if (response.statusCode == 200) {
        return DetailRestaurantResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load restaurant details. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load restaurant details: $e');
    }
  }

  Future<RestaurantListResponse> searchRestaurant(String query) async {
    final response = await http.get(
      Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query'),
    );

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search restaurants');
    }
  }
}
