import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/repositories/food_repository.dart';
import 'package:challenge/app/features/home/domain/usecases/save_food_offline_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('Save food offline usecase', () {
    setUpAll(() {
      registerFallbackValue(
        FoodEntity(
          publisher: 'Closet Cooking',
          imageUrl:
              'http://forkify-api.herokuapp.com/images/Pizza2BQuesadillas2B2528aka2BPizzadillas25292B5002B834037bf306b.jpg',
          originUrl:
              'http://www.closetcooking.com/2012/11/pizza-quesadillas-aka-pizzadillas.html',
          title: 'Pizza Quesadillas (aka Pizzadillas)',
          id: 'sdsf',
        ),
      );
    });
    test('Should return foods of db then this method is called', () async {
      final foodRepository = FoodRepositoryMock();

      final saveFoodUsecase = SaveFoodOfflineUsecase(
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
        () => foodRepository.saveFoodOffline(
          food: any(
            named: 'food',
          ),
        ),
      ).thenAnswer(
        (_) => getFoods(),
      );

      final foods = (await saveFoodUsecase(
              food: FoodEntity(
        publisher: 'Closet Cooking',
        imageUrl:
            'http://forkify-api.herokuapp.com/images/Pizza2BQuesadillas2B2528aka2BPizzadillas25292B5002B834037bf306b.jpg',
        originUrl:
            'http://www.closetcooking.com/2012/11/pizza-quesadillas-aka-pizzadillas.html',
        title: 'Pizza Quesadillas (aka Pizzadillas)',
        id: 'sdsf',
      )))
          .fold((l) => null, (r) => r);

      expect(foods, isA<bool>());
      expect(foods, isTrue);
    });

    test('Should return error then this method is called', () async {
      final foodRepository = FoodRepositoryMock();

      final saveFoodUsecase = SaveFoodOfflineUsecase(
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
        () => foodRepository.saveFoodOffline(
          food: any(
            named: 'food',
          ),
        ),
      ).thenAnswer(
        (_) => getFoods(),
      );

      final foods = (await saveFoodUsecase(
        food: FoodEntity(
          publisher: 'Closet Cooking',
          imageUrl:
              'http://forkify-api.herokuapp.com/images/Pizza2BQuesadillas2B2528aka2BPizzadillas25292B5002B834037bf306b.jpg',
          originUrl:
              'http://www.closetcooking.com/2012/11/pizza-quesadillas-aka-pizzadillas.html',
          title: 'Pizza Quesadillas (aka Pizzadillas)',
          id: 'sdsf',
        ),
      ))
          .fold(
        (l) => l,
        (r) => null,
      );

      expect(foods, isA<FoodFailure>());
      expect(foods, isException);
    });
  });
}

class FoodRepositoryMock extends Mock implements FoodRepository {}
