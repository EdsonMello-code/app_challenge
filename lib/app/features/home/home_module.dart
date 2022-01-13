import 'package:challenge/app/features/home/domain/usecases/get_food_offline_usecase.dart';
import 'package:challenge/app/features/home/domain/usecases/remove_food_offline_usecase.dart';
import 'package:challenge/app/features/home/domain/usecases/save_food_offline_usecase.dart';
import 'package:challenge/app/features/home/externals/adapters/database/database.dart';
import 'package:challenge/app/features/home/externals/adapters/database/sqlite_database.dart';
import 'package:challenge/app/features/home/presenter/controllers/home_controller.dart';
import 'package:challenge/app/features/home/presenter/controllers/favorited_controller.dart';
import 'package:challenge/app/features/home/presenter/pages/favorited_page.dart';
import 'package:challenge/app/features/home/presenter/pages/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/food_repository.dart';
import 'domain/usecases/get_foods_api_usecase.dart';
import 'externals/adapters/http_client/dio_client.dart';
import 'externals/adapters/http_client/http_client.dart';
import 'externals/datasources/food_datasource_impl.dart';
import 'infra/datasources/food_datasource.dart';
import 'infra/repository/food_repository_impl.dart';

class HomeModule extends Module {
  @override
  List<Bind> binds = [
    Bind.lazySingleton<IDatabase>((i) => SqliteDatabase()),
    Bind.lazySingleton<FoodRepository>((i) => FoodRepositoryImpl(i())),
    Bind.lazySingleton<FoodDatasource>((i) => FoodDatasourceImpl(i(), i())),
    Bind.lazySingleton<IGetFoodOfflineUsecase>(
      (i) => GetFoodOfflineUsecase(
        i(),
      ),
    ),
    Bind.lazySingleton<IGetFoodOfflineUsecase>(
      (i) => GetFoodOfflineUsecase(
        i(),
      ),
    ),
    Bind.lazySingleton<GetFoodsUsecase>((i) => GetFoodsUsecase(i())),
    Bind.lazySingleton<IHttpClient>(
      (i) => DioClient(
        client: Dio(),
      ),
    ),
    Bind.lazySingleton(
      (i) => HomeController(
        getFoodsUsecase: i(),
      ),
    ),
    Bind.lazySingleton<ISaveFoodOfflineUsecase>(
      (i) => SaveFoodOfflineUsecase(
        repository: i(),
      ),
    ),
    Bind.lazySingleton<IRemoveFoodOfflineUsecase>(
      (i) => RemoveFoodOfflineUsecase(
        repository: i(),
      ),
    ),
    Bind.factory(
      (i) => FavoritedController(
        i(),
        i(),
        i(),
      ),
    ),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const HomePage(),
    ),
    ChildRoute(
      '/favorited',
      child: (_, args) => const FavoritedPage(),
    ),
  ];
}
