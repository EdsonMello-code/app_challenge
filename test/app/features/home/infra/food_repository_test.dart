import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/domain/repositories/food_repository.dart';
import 'package:challenge/app/features/home/infra/datasources/food_datasource.dart';
import 'package:challenge/app/features/home/infra/repository/food_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
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

  late FoodDatasourceMock foodDatasource;
  late FoodRepository foodRepository;

  setUp(() {
    foodDatasource = FoodDatasourceMock();

    foodRepository = FoodRepositoryImpl(foodDatasource);
  });
  group('Food repository |  get foods', () {
    test('Should return list of food then this method is called.', () async {
      when(
        () => foodDatasource.getFoodsDatasource(
          foodName: any(named: 'foodName'),
        ),
      ).thenAnswer((_) async => [
            FoodEntity(
              publisher: 'Closet Cooking',
              imageUrl:
                  'http://forkify-api.herokuapp.com/images/Pizza2BQuesadillas2B2528aka2BPizzadillas25292B5002B834037bf306b.jpg',
              originUrl:
                  'http://www.closetcooking.com/2012/11/pizza-quesadillas-aka-pizzadillas.html',
              title: 'Pizza Quesadillas (aka Pizzadillas)',
              id: 'iddfsdf',
            )
          ]);

      when(
        () => foodDatasource.getFoodsOfflineDatasource(),
      ).thenAnswer((_) async => [
            FoodEntity(
              publisher: 'Closet Cooking',
              imageUrl:
                  'http://forkify-api.herokuapp.com/images/Pizza2BQuesadillas2B2528aka2BPizzadillas25292B5002B834037bf306b.jpg',
              originUrl:
                  'http://www.closetcooking.com/2012/11/pizza-quesadillas-aka-pizzadillas.html',
              title: 'Pizza Quesadillas (aka Pizzadillas)',
              id: 'iddfsdf',
            ),
            FoodEntity(
              publisher: 'Closet Cooking other',
              imageUrl:
                  'http://forkify-api.herokuapp.com/images/Pizza2BQuesadillas2B2528aka2BPizzadillas25292B5002B834037bf306b.jpg',
              originUrl:
                  'http://www.closetcooking.com/2012/11/pizza-quesadillas-aka-pizzadillas.html',
              title: 'Pizza Quesadillas (aka Pizzadillas)',
              id: 'iddfsdf',
            )
          ]);

      final foods = (await foodRepository.getFoods(foodName: 'Pizza'))
          .fold((l) => null, (r) => r);

      expect(foods, isNotEmpty);
      expect(foods, isA<List<FoodEntity>>());
      expect(foods![0].imageUrl, isNotEmpty);
      expect(foods[0].originUrl, isNotEmpty);
      expect(foods[0].publisher, isNotEmpty);
      expect(foods[0].title, isNotEmpty);
    });

    test('Should return error then this method is called.', () async {
      when(
        () => foodDatasource.getFoodsDatasource(
          foodName: any(named: 'foodName'),
        ),
      ).thenThrow(FoodFailure('Foods is null'));

      final foods = (await foodRepository.getFoods(foodName: 'Pizza'))
          .fold((l) => l, (r) => null);

      expect(foods, isException);
      expect(foods!.message, 'Foods is null');
    });
  });

  group('Food repository | save food offline', () {
    test('Should return list of food then this method is called', () async {
      when(
        () => foodDatasource.saveFoodDatasource(
          food: any(
            named: 'food',
          ),
        ),
      ).thenAnswer(
        (_) async => true,
      );

      final isSavedfood = (await foodRepository.saveFoodOffline(
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

      expect(isSavedfood, isA<bool>());
      expect(isSavedfood, isTrue);
    });

    test('Should return error then this method is called', () async {
      when(
        () => foodDatasource.saveFoodDatasource(
          food: any(
            named: 'food',
          ),
        ),
      ).thenThrow(FoodFailure('Don´t save food in database'));

      final isSavedfood = (await foodRepository.saveFoodOffline(
              food: FoodEntity(
        publisher: 'Closet Cooking',
        imageUrl:
            'http://forkify-api.herokuapp.com/images/Pizza2BQuesadillas2B2528aka2BPizzadillas25292B5002B834037bf306b.jpg',
        originUrl:
            'http://www.closetcooking.com/2012/11/pizza-quesadillas-aka-pizzadillas.html',
        title: 'Pizza Quesadillas (aka Pizzadillas)',
        id: 'sdsf',
      )))
          .fold((l) => l, (r) => null);

      expect(isSavedfood, isA<FoodFailure>());
      expect(isSavedfood, isException);
    });
  });

  group('Food repository | remove food offline', () {
    test('Should remove food then this method is called', () async {
      when(
        () => foodDatasource.removeFoodOfflineDatasource(
          id: any(
            named: 'id',
          ),
        ),
      ).thenAnswer(
        (_) async => true,
      );

      final isSavedfood = (await foodRepository.removeFoodOffline(
        id: 'sdfsdfs',
      ))
          .fold(
        (l) => null,
        (r) => r,
      );

      expect(isSavedfood, isA<bool>());
      expect(isSavedfood, isTrue);
    });

    test('Should  return error then to try remove food', () async {
      when(
        () => foodDatasource.removeFoodOfflineDatasource(
          id: any(
            named: 'id',
          ),
        ),
      ).thenThrow(FoodFailure('Don´t save food in database'));

      final isSavedfood = (await foodRepository.removeFoodOffline(
        id: 'dsfsdf',
      ))
          .fold(
        (l) => l,
        (r) => null,
      );

      expect(isSavedfood, isA<FoodFailure>());
      expect(isSavedfood, isException);
    });
  });

  group('Food repository | get foods offline', () {
    test('Should return foods then this method is called', () async {
      when(() => foodDatasource.getFoodsOfflineDatasource()).thenAnswer(
        (_) async => [
          FoodEntity(
            publisher: 'Closet Cooking',
            imageUrl:
                'http://forkify-api.herokuapp.com/images/Pizza2BQuesadillas2B2528aka2BPizzadillas25292B5002B834037bf306b.jpg',
            originUrl:
                'http://www.closetcooking.com/2012/11/pizza-quesadillas-aka-pizzadillas.html',
            title: 'Pizza Quesadillas (aka Pizzadillas)',
            id: 'iddfsdf',
          )
        ],
      );

      final foods = (await foodRepository.getFoodsOffline()).fold(
        (l) => null,
        (r) => r,
      );
      expect(foods, isA<List<FoodEntity>>());
      expect(foods, isNotEmpty);
    });

    test('Should return error then this method is called', () async {
      when(() => foodDatasource.getFoodsOfflineDatasource())
          .thenThrow(FoodFailure('Foods is null'));

      final foods = (await foodRepository.getFoodsOffline()).fold(
        (l) => l,
        (r) => null,
      );
      expect(foods, isA<FoodFailure>());
      expect(foods, isException);
    });
  });
}

class FoodDatasourceMock extends Mock implements FoodDatasource {}
