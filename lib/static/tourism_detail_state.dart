import 'package:restaurant_app/model/detail_restaurant_respons.dart';

abstract class TourismDetailResultState {}

class TourismDetailIdle extends TourismDetailResultState {}

class TourismDetailLoading extends TourismDetailResultState {}

class TourismDetailCompleteWithError extends TourismDetailResultState {
  final String errorMessage;

  TourismDetailCompleteWithError(this.errorMessage);
}

class TourismDetailCompleteWithValue extends TourismDetailResultState {
  final DetailRestaurantResponse detailRestaurant;

  TourismDetailCompleteWithValue(this.detailRestaurant);
}
