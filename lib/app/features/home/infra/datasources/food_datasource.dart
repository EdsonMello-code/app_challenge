import 'package:challenge/app/features/home/domain/entities/food_entity.dart';

abstract class FoodDatasource {
  Future<bool> saveFoodDatasource({required FoodEntity food});
  Future<bool> removeFoodOfflineDatasource({required String id});
  Future<List<FoodEntity>> getFoodsDatasource({required String foodName});
  Future<List<FoodEntity>> getFoodsOfflineDatasource();
}
