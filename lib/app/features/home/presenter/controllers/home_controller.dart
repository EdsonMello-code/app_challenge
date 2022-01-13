import 'package:challenge/app/features/home/domain/usecases/get_foods_api_usecase.dart';
import 'package:challenge/app/features/home/presenter/controllers/state/food_state.dart';
import 'package:flutter/widgets.dart';

class HomeController extends ValueNotifier<FoodState> {
  final GetFoodsUsecase getFoodsUsecase;

  HomeController({required this.getFoodsUsecase}) : super(FoodStateStart());

  Future<void> fetchFoods({required String foodName}) async {
    if (foodName.isEmpty) return;

    value = FoodStateLoading();

    final foods = await getFoodsUsecase.call(foodName: foodName);
    foods.fold(
      (l) {
        value = FoodStateFailures(message: l.message);
      },
      (r) {
        value = FoodStateSuccess(r);
      },
    );
  }
}
