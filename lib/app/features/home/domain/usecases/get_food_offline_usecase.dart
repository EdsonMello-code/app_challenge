import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/repositories/food_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IGetFoodOfflineUsecase {
  final FoodRepository foodRepository;

  IGetFoodOfflineUsecase({required this.foodRepository});
  Future<Either<FoodFailure, List<FoodEntity>>> call();
}

class GetFoodOfflineUsecase implements IGetFoodOfflineUsecase {
  @override
  final FoodRepository foodRepository;

  GetFoodOfflineUsecase(this.foodRepository);

  @override
  Future<Either<FoodFailure, List<FoodEntity>>> call() async {
    return foodRepository.getFoodsOffline();
  }
}
