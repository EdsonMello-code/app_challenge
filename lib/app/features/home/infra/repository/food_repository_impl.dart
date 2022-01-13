import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/repositories/food_repository.dart';
import 'package:challenge/app/features/home/infra/datasources/food_datasource.dart';
import 'package:dartz/dartz.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodDatasource foodDatasource;

  FoodRepositoryImpl(this.foodDatasource);

  @override
  Future<Either<FoodFailure, List<FoodEntity>>> getFoods({
    required String foodName,
  }) async {
    try {
      final foodsOnline =
          await foodDatasource.getFoodsDatasource(foodName: foodName);
      final foodsOffline = await foodDatasource.getFoodsOfflineDatasource();

      final foods = foodsOnline
          .where(
            (item) => !foodsOffline.contains(item),
          )
          .toList();

      return Right(foods);
    } on FoodFailure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FoodFailure, bool>> saveFoodOffline({
    required FoodEntity food,
  }) async {
    try {
      final isFoodSaved = await foodDatasource.saveFoodDatasource(food: food);
      return Right(isFoodSaved);
    } on FoodFailure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FoodFailure, bool>> removeFoodOffline({
    required String id,
  }) async {
    try {
      final food = await foodDatasource.removeFoodOfflineDatasource(id: id);
      return Right(food);
    } on FoodFailure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FoodFailure, List<FoodEntity>>> getFoodsOffline() async {
    try {
      final foods = await foodDatasource.getFoodsOfflineDatasource();
      return Right(foods);
    } on FoodFailure catch (error) {
      return Left(error);
    }
  }
}
