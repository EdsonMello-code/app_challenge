import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/repositories/food_repository.dart';
import 'package:challenge/app/features/home/domain/usecases/remove_food_offline_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('Remove food offline usecase', () {
    test('Should return remove food then this method is called ', () async {
      final foodRepository = FoodRepositoryMock();

      final removeFoodOfflineUsecase = RemoveFoodOfflineUsecase(
        repository: foodRepository,
      );

      Future<Either<FoodFailure, bool>> getFoods() async {
        try {
          return const Right(true);
        } on FoodFailure catch (error) {
          return Left(error);
        }
      }

      when(
        () => foodRepository.removeFoodOffline(
          id: any(
            named: 'id',
          ),
        ),
      ).thenAnswer(
        (_) => getFoods(),
      );

      final food = (await removeFoodOfflineUsecase(id: 'any'))
          .fold((l) => null, (r) => r);

      expect(food, isA<bool>());
      expect(food, isTrue);
    });

    test('Should return error then this method is called', () async {
      final foodRepository = FoodRepositoryMock();

      final removeFoodUsecase = RemoveFoodOfflineUsecase(
        repository: foodRepository,
      );

      Future<Either<FoodFailure, bool>> getFoods() async {
        try {
          throw FoodFailure('Erro in save food');
        } on FoodFailure catch (error) {
          return Left(error);
        }
      }

      when(
        () => foodRepository.removeFoodOffline(
          id: any(
            named: 'id',
          ),
        ),
      ).thenAnswer(
        (_) => getFoods(),
      );

      final foods = (await removeFoodUsecase(id: 'fsf')).fold(
        (l) => l,
        (r) => null,
      );

      expect(foods, isA<FoodFailure>());
      expect(foods, isException);
    });
  });
}

class FoodRepositoryMock extends Mock implements FoodRepository {}
