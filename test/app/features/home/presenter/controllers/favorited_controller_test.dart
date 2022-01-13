import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/usecases/get_food_offline_usecase.dart';
import 'package:challenge/app/features/home/domain/usecases/remove_food_offline_usecase.dart';
import 'package:challenge/app/features/home/domain/usecases/save_food_offline_usecase.dart';
import 'package:challenge/app/features/home/presenter/controllers/favorited_controller.dart';
import 'package:challenge/app/features/home/presenter/controllers/state/food_favorited_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:value_listenable_test/value_listenable_test.dart';

void main() {
  group('Favorited controller | save food', () {
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

    late SaveFoodOfflineUsecaseMock saveFoodOfflineUsecase;
    late RemoveFoodOfflineUsecaseMock removeFoodOfflineUsecase;
    late GetFoodOfflineUsecaseMock getFoodOfflineUsecase;
    late FavoritedController favoritedController;

    setUp(() {
      saveFoodOfflineUsecase = SaveFoodOfflineUsecaseMock();
      removeFoodOfflineUsecase = RemoveFoodOfflineUsecaseMock();
      getFoodOfflineUsecase = GetFoodOfflineUsecaseMock();

      favoritedController = FavoritedController(
        saveFoodOfflineUsecase,
        removeFoodOfflineUsecase,
        getFoodOfflineUsecase,
      );
    });

    test('Should return foods in db', () async {
      Future<Either<FoodFailure, bool>> getFoods() async {
        try {
          return const Right(true);
        } on FoodFailure catch (error) {
          return Left(error);
        }
      }

      when(
        () => saveFoodOfflineUsecase.call(
          food: any(named: 'food'),
        ),
      ).thenAnswer(
        (_) => getFoods(),
      );

      expect(
        favoritedController,
        emitValues(
          [
            isA<FoodFavoritedStateLoading>(),
            isA<FoodFavoritedStateSuccess>(),
          ],
        ),
      );

      await favoritedController.saveFood(
        food: FoodEntity(
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

    test('Should return error', () async {
      Future<Either<FoodFailure, bool>> getFoods() async {
        try {
          throw FoodFailure('Db not exist');
        } on FoodFailure catch (error) {
          return Left(error);
        }
      }

      when(
        () => saveFoodOfflineUsecase.call(
          food: any(named: 'food'),
        ),
      ).thenAnswer(
        (_) => getFoods(),
      );

      expect(
        favoritedController,
        emitValues(
          [
            isA<FoodFavoritedStateLoading>(),
            isA<FoodFavoritedStateFailure>(),
          ],
        ),
      );
      await favoritedController.saveFood(
        food: FoodEntity(
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
  });
}

class SaveFoodOfflineUsecaseMock extends Mock
    implements SaveFoodOfflineUsecase {}

class RemoveFoodOfflineUsecaseMock extends Mock
    implements RemoveFoodOfflineUsecase {}

class GetFoodOfflineUsecaseMock extends Mock implements GetFoodOfflineUsecase {}
