import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/repositories/food_repository.dart';
import 'package:challenge/app/features/home/domain/usecases/get_food_offline_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late FoodRepository foodRepository;
  setUp(() {
    foodRepository = FoodRepositoryMock();
  });
  group('Get food offline usecase', () {
    test('Should return foods of database then this method is called',
        () async {
      final getFoodOfflineUsecase = GetFoodOfflineUsecase(foodRepository);
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

      when(() => foodRepository.getFoodsOffline()).thenAnswer(
        (_) => getFoods(),
      );

      final foods = (await getFoodOfflineUsecase()).fold((l) => null, (r) => r);
      expect(foods, isA<List<FoodEntity>>());
      expect(foods, isNotEmpty);
    });

    test('Should return error of database then this method is called',
        () async {
      final getFoodOfflineUsecase = GetFoodOfflineUsecase(foodRepository);
      Future<Either<FoodFailure, List<FoodEntity>>> getFoods() async {
        try {
          throw FoodFailure('Food is not fetch of database');
        } on FoodFailure catch (error) {
          return Left(error);
        }
      }

      when(() => foodRepository.getFoodsOffline()).thenAnswer(
        (_) => getFoods(),
      );

      final foods = (await getFoodOfflineUsecase()).fold((l) => l, (r) => null);
      expect(foods, isA<FoodFailure>());
      expect(foods, isException);
    });
  });
}

class FoodRepositoryMock extends Mock implements FoodRepository {}
