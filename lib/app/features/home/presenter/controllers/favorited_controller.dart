import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/usecases/get_food_offline_usecase.dart';
import 'package:challenge/app/features/home/domain/usecases/remove_food_offline_usecase.dart';
import 'package:challenge/app/features/home/domain/usecases/save_food_offline_usecase.dart';
import 'package:challenge/app/features/home/presenter/controllers/state/food_favorited_state.dart';
import 'package:flutter/widgets.dart';

class FavoritedController extends ValueNotifier<FoodFavoritedState> {
  FavoritedController(
    this.saveFoodOfflineUsecase,
    this.removeFoodOfflineUsecase,
    this.getFoodOfflineUsecase,
  ) : super(
          FoodFavoritedStateStart(),
        );
  final SaveFoodOfflineUsecase saveFoodOfflineUsecase;
  final RemoveFoodOfflineUsecase removeFoodOfflineUsecase;
  final GetFoodOfflineUsecase getFoodOfflineUsecase;

  Future<void> saveFood({required FoodEntity food}) async {
    value = FoodFavoritedStateLoading();

    final response = await saveFoodOfflineUsecase(food: food);

    response.fold((l) {
      value = FoodFavoritedStateFailure(l.message);
    }, (r) {
      value = FoodFavoritedStateSuccess([]);
    });
  }

  Future<void> removeFood({required String id}) async {
    value = FoodFavoritedStateLoading();
    final response = await removeFoodOfflineUsecase(id: id);

    response.fold((l) {
      value = FoodFavoritedStateFailure(l.message);
    }, (r) {
      value = FoodFavoritedStateSuccess([]);
    });
  }

  Future<void> fetchFoodOffline() async {
    value = FoodFavoritedStateLoading();
    final foodResponse = await getFoodOfflineUsecase();
    foodResponse.fold(
      (l) {
        value = FoodFavoritedStateFailure(l.message);
      },
      (r) {
        value = FoodFavoritedStateSuccess(r);
      },
    );
  }
}
