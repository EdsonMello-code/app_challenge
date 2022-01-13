import 'package:challenge/app/features/home/domain/entities/food_entity.dart';

abstract class FoodState {}

class FoodStateStart implements FoodState {}

class FoodStateLoading implements FoodState {}

class FoodStateSuccess implements FoodState {
  final List<FoodEntity> foods;

  FoodStateSuccess(this.foods);
}

class FoodStateFailures implements FoodState {
  final String message;

  FoodStateFailures({required this.message});
}
