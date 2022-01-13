import 'package:challenge/app/features/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];
  @override
  List<ModularRoute> routes = [
    ModuleRoute(
      Modular.initialRoute,
      module: HomeModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
