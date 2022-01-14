import 'package:challenge/app/features/home/domain/entities/food_entity.dart';
import 'package:challenge/app/features/home/domain/errors/food_failure.dart';
import 'package:challenge/app/features/home/externals/adapters/database/database.dart';
import 'package:challenge/app/features/home/externals/adapters/http_client/http_client.dart';
import 'package:challenge/app/features/home/externals/models/food_model.dart';
import 'package:challenge/app/features/home/infra/datasources/food_datasource.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

class FoodDatasourceImpl implements FoodDatasource {
  final IHttpClient httpClient;

  final IDatabase database;

  final _createTableSql = ''' 
      CREATE TABLE IF NOT EXISTS foods (
        id TEXT PRIMARY KEY,
        publisher TEXT, 
        isSelected BOOLEAN NOT NULL CHECK (isSelected IN (0,1)),
        imageUrl TEXT, 
        originUrl TEXT, 
        title TEXT
      );
    ''';

  Future<Database> initConnection() async {
    final connection = await _databaseConnection;
    await connection.execute(_createTableSql);

    return connection;
  }

  Future<Database> get _databaseConnection async =>
      await database.openConnection();

  FoodDatasourceImpl(this.httpClient, this.database);
  @override
  Future<List<FoodEntity>> getFoodsDatasource({
    required String foodName,
  }) async {
    try {
      final response =
          await httpClient.get(endPoint: '/search', queryParameters: {
        'q': foodName,
      });

      final data = response.data['recipes'] as List;

      return data.map((food) => FoodModel.fromMap(food)).toList();
    } on DioError catch (_) {
      throw FoodFailure('Connection error! verify your internet.');
    } catch (e) {
      throw FoodFailure('Inexpected Error');
    }
  }

  @override
  Future<bool> saveFoodDatasource({required FoodEntity food}) async {
    try {
      final connection = await initConnection();

      await connection.insert(
        'foods',
        {
          "id": food.id,
          "title": food.title,
          "imageUrl": food.imageUrl,
          "originUrl": food.originUrl,
          "publisher": food.publisher,
          "isSelected": food.isSelected ? 1 : 0
        },
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );

      return true;
    } catch (e) {
      throw FoodFailure('User already be saved.');
    }
  }

  @override
  Future<bool> removeFoodOfflineDatasource({required String id}) async {
    try {
      final connection = await initConnection();

      await connection.delete(
        'foods',
        where: 'id = ?',
        whereArgs: [id],
      );

      return true;
    } catch (e) {
      throw FoodFailure(e.toString());
    }
  }

  @override
  Future<List<FoodEntity>> getFoodsOfflineDatasource() async {
    try {
      final connection = await initConnection();

      final foods = await connection.query('foods', columns: [
        'id',
        'publisher',
        'isSelected',
        'imageUrl',
        'originUrl',
        'title'
      ]);

      return foods.map((food) => FoodModel.fromMapDatabase(food)).toList();
    } catch (e) {
      throw FoodFailure(e.toString());
    }
  }
}
