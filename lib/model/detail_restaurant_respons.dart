class DetailRestaurantResponse {
  final bool error;
  final String message;
  final RestaurantDetail restaurant;

  DetailRestaurantResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) {
    return DetailRestaurantResponse(
      error: json['error'] ?? false,
      message: json['message'] ?? '',
      restaurant: RestaurantDetail.fromJson(json['restaurant']),
    );
  }

  String get address => restaurant.address;
  String get city => restaurant.city;
  String get description => restaurant.description;
  double get rating => restaurant.rating;
  List<Category> get categories => restaurant.categories;
  Menus get menu => restaurant.menu;
  List<CustomerReview> get customerReviews => restaurant.customerReviews;
  String get id => restaurant.id;
  String get pictureId => restaurant.pictureId;
  String get name => restaurant.name;
}

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final double rating;
  final List<Category> categories;
  final Menus menu;
  final List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.rating,
    required this.categories,
    required this.menu,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
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
      menu: Menus.fromJson(json['menus']),
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

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'] ?? '',
      review: json['review'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
