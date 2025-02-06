import 'dart:convert';

DetailRestaurant detailRestaurantFromJson(String str) =>
    DetailRestaurant.fromJson(json.decode(str));

class DetailRestaurant {
  final Restaurant restaurant;

  DetailRestaurant({required this.restaurant});

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) {
    return DetailRestaurant(
      restaurant: Restaurant.fromJson(json['restaurant']),
    );
  }

  // Return values from the Restaurant object
  String get address => restaurant.address;
  String get city => restaurant.city;
  String get description => restaurant.description;
  double get rating => restaurant.rating;
  List<Category> get categories => restaurant.categories;
  Menus get menus => restaurant.menus;
  List<CustomerReview> get customerReviews => restaurant.customerReviews;
  String get id => restaurant.id;
  String get pictureId => restaurant.pictureId;
  String get name => restaurant.name;
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final double rating;
  final List<Category> categories;
  final Menus menus;
  final List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      pictureId: json['pictureId'] ?? '',
      rating: (json['rating'] as num).toDouble(),
      categories: (json['categories'] as List)
          .map((category) => Category.fromJson(category))
          .toList(),
      menus: Menus.fromJson(json['menus']),
      customerReviews: (json['customerReviews'] as List)
          .map((review) => CustomerReview.fromJson(review))
          .toList(),
    );
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'] ?? '');
  }
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods:
          (json['foods'] as List).map((food) => Food.fromJson(food)).toList(),
      drinks: (json['drinks'] as List)
          .map((drink) => Drink.fromJson(drink))
          .toList(),
    );
  }
}

class Food {
  final String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(name: json['name'] ?? '');
  }
}

class Drink {
  final String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(name: json['name'] ?? '');
  }
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview(
      {required this.name, required this.review, required this.date});

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'] ?? '',
      review: json['review'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
