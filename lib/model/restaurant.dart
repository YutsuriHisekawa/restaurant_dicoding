class Restaurant {
  String? id;
  String? name;
  String? city;
  double? rating;
  String? pictureId;

  Restaurant({
    required this.id,
    required this.name,
    required this.city,
    required this.rating,
    required this.pictureId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "city": city,
      "rating": rating,
      "pictureId": pictureId,
    };
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      rating: (json['rating'] as num).toDouble(),
      pictureId: json['pictureId'] as String,
    );
  }
}
