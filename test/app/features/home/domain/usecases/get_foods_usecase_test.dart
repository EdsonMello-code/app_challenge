import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/repositories/food_repository.dart';
import 'package:challenge/app/features/home/domain/usecases/get_foods_api_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('Get foods usecase: ', () {
    test('Should return list of foods then this usecase is called.', () async {
      final foodRepository = FoodRepositoryMock();

      final getFoodsUsecase = GetFoodsUsecase(foodRepository);
      Future<Either<FoodFailure, List<FoodEntity>>> getFoods() async {
        try {
          return Right([
            FoodEntity(
                publisher: 'Closet Cooking',
                imageUrl:
                    'http://forkify-api.herokuapp.com/images/Pizza2BQuesadillas2B2528aka2BPizzadillas25292B5002B834037bf306b.jpg',
                originUrl:
                    'http://www.closetcooking.com/2012/11/pizza-quesadillas-aka-pizzadillas.html',
                title: 'Pizza Quesadillas (aka Pizzadillas)',
                id: 'sdsf')
          ]);
        } on FoodFailure catch (error) {
          return Left(error);
        }
      }

      when(() => foodRepository.getFoods(foodName: any(named: 'foodName')))
          .thenAnswer(
        (_) => getFoods(),
      );

      final foods = (await getFoodsUsecase(foodName: 'Closet Cooking')).fold(
        (l) => null,
        (r) => r,
      );

      expect(foods, isNotEmpty);
      expect(foods, isA<List<FoodEntity>>());
      expect(foods![0].imageUrl, isNotEmpty);
      expect(foods[0].originUrl, isNotEmpty);
      expect(foods[0].publisher, isNotEmpty);
      expect(foods[0].title, isNotEmpty);
    });

    test('Should return food error then this usecase is called.', () async {
      final foodRepository = FoodRepositoryMock();

      final getFoodsUsecase = GetFoodsUsecase(foodRepository);
      Future<Either<FoodFailure, List<FoodEntity>>> getFoods() async {
        try {
          throw FoodFailure('Foods is null');
        } on FoodFailure catch (error) {
          return Left(error);
        }
      }

      when(() => foodRepository.getFoods(foodName: any(named: 'foodName')))
          .thenAnswer(
        (_) => getFoods(),
      );

      final foods = (await getFoodsUsecase(foodName: 'Closet Cooking')).fold(
        (l) => l,
        (r) => null,
      );

      expect(foods, isException);
      expect(foods!.message, equals('Foods is null'));
    });
  });
}

class FoodRepositoryMock extends Mock implements FoodRepository {}
