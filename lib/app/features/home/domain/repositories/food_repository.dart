import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:dartz/dartz.dart';

abstract class FoodRepository {
  Future<Either<FoodFailure, List<FoodEntity>>> getFoods({
    required String foodName,
  });

  Future<Either<FoodFailure, bool>> saveFoodOffline({required FoodEntity food});
  Future<Either<FoodFailure, bool>> removeFoodOffline({required String id});
  Future<Either<FoodFailure, List<FoodEntity>>> getFoodsOffline();
}
