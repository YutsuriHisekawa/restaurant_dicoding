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
      rethrow;
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
      rethrow;
    }
  }

  Future<RestaurantListResponse> searchRestaurant(String query) async {
    try {
      final response = await http.get(
        Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query'),
      );

      if (response.statusCode == 200) {
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to search restaurants');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postReview(
      String restaurantId, String name, String review) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/review'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': restaurantId,
          'name': name,
          'review': review,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to post review');
      }
    } catch (e) {
      rethrow;
    }
  }
}
