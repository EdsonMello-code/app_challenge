import 'package:challenge/app/features/home/domain/entities/food_entity.dart';

abstract class FoodFavoritedState {}

class FoodFavoritedStateStart implements FoodFavoritedState {}

class FoodFavoritedStateLoading implements FoodFavoritedState {}

class FoodFavoritedStateSuccess implements FoodFavoritedState {
  final List<FoodEntity> foods;

  FoodFavoritedStateSuccess(this.foods);
}

class FoodFavoritedStateFailure implements FoodFavoritedState {
  final String message;

  FoodFavoritedStateFailure(this.message);
}
