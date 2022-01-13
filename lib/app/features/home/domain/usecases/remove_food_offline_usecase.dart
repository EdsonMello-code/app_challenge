import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/repositories/food_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IRemoveFoodOfflineUsecase {
  final FoodRepository repository;

  IRemoveFoodOfflineUsecase({required this.repository});
  Future<Either<FoodFailure, bool>> call({required String id});
}

class RemoveFoodOfflineUsecase implements IRemoveFoodOfflineUsecase {
  @override
  final FoodRepository repository;

  RemoveFoodOfflineUsecase({required this.repository});

  @override
  Future<Either<FoodFailure, bool>> call({required String id}) {
    return repository.removeFoodOffline(id: id);
  }
}
