class Restaurant {
  final String id;
  final String name;
  final String city;
  final double rating;
  final String pictureId;

  Restaurant({
    required this.id,
    required this.name,
    required this.city,
    required this.rating,
    required this.pictureId,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      rating: json['rating'].toDouble(),
      pictureId: json['pictureId'],
    );
  }
}
