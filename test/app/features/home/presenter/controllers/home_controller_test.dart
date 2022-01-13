import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/usecases/get_foods_api_usecase.dart';
import 'package:challenge/app/features/home/presenter/controllers/home_controller.dart';
import 'package:challenge/app/features/home/presenter/controllers/state/food_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:value_listenable_test/value_listenable_test.dart';

void main() {
  group('Home controller | fetch foods', () {
    test('Should return Food state then this method is called', () async {
      final getFoodsUsecaseMock = GetFoodsUsecaseMock();

      final homeController = HomeController(
        getFoodsUsecase: getFoodsUsecaseMock,
      );

      when(
        () => getFoodsUsecaseMock.call(
          foodName: any(named: 'foodName'),
        ),
      ).thenAnswer((_) => getFoods());

      expect(
        homeController,
        emitValues(
          [isA<FoodStateLoading>(), isA<FoodStateSuccess>()],
        ),
      );
      await homeController.fetchFoods(foodName: 'Pizza');
    });

    test('Should return food failure then this method is called', () async {
      final getFoodsUsecaseMock = GetFoodsUsecaseMock();
      final homeController =
          HomeController(getFoodsUsecase: getFoodsUsecaseMock);

      Future<Either<FoodFailure, List<FoodEntity>>> getFoods() async {
        try {
          throw FoodFailure('Foods is null');
        } on FoodFailure catch (error) {
          return Left(error);
        }
      }

      when(() => getFoodsUsecaseMock.call(foodName: any(named: 'foodName')))
          .thenAnswer(
        (_) async => await getFoods(),
      );

      expect(
        homeController,
        emitValues(
          [isA<FoodStateLoading>(), isA<FoodStateFailures>()],
        ),
      );
      await homeController.fetchFoods(foodName: 'Pizza');
    });
  });
}

class GetFoodsUsecaseMock extends Mock implements GetFoodsUsecase {}

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
          isSelected: true,
          id: 'sdsf'),
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
