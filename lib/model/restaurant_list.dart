class RestaurantListResponse {
  final List<Restaurant> restaurants;

  RestaurantListResponse({required this.restaurants});

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] == null) {
      return RestaurantListResponse(restaurants: []);
    }

    var list = json['restaurants'] as List;
    List<Restaurant> restaurantList =
        list.map((i) => Restaurant.fromJson(i)).toList();

    return RestaurantListResponse(restaurants: restaurantList);
  }
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'].toDouble(),
    );
  }
}
