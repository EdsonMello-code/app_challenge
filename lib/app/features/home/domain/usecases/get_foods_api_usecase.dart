import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/repositories/food_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetFoodsUsecase {
  final FoodRepository repository;

  IGetFoodsUsecase(this.repository);

  Future<Either<FoodFailure, List<FoodEntity>>> call({
    required String foodName,
  });
}

class GetFoodsUsecase implements IGetFoodsUsecase {
  @override
  final FoodRepository repository;

  GetFoodsUsecase(this.repository);

  @override
  Future<Either<FoodFailure, List<FoodEntity>>> call({
    required String foodName,
  }) {
    return repository.getFoods(foodName: foodName.trim());
  }
}
