import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/repositories/food_repository.dart';
import 'package:dartz/dartz.dart';

abstract class ISaveFoodOfflineUsecase {
  final FoodRepository repository;

  ISaveFoodOfflineUsecase({required this.repository});
  Future<Either<FoodFailure, bool>> call({required FoodEntity food});
}

class SaveFoodOfflineUsecase implements ISaveFoodOfflineUsecase {
  @override
  final FoodRepository repository;

  SaveFoodOfflineUsecase({required this.repository});

  @override
  Future<Either<FoodFailure, bool>> call({required FoodEntity food}) {
    return repository.saveFoodOffline(food: food);
  }
}
