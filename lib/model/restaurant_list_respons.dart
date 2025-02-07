import 'restaurant.dart'; 

class RestaurantListResponse {
  final List<Restaurant> restaurants;

  RestaurantListResponse({required this.restaurants});

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    var list = json['restaurants'] as List;
    List<Restaurant> restaurantsList =
        list.map((i) => Restaurant.fromJson(i)).toList();
    return RestaurantListResponse(restaurants: restaurantsList);
  }
}
