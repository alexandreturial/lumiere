import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/core/themes/theme_service.dart';
import 'package:lumiere/app/modules/movies/movies_module.dart';
import 'package:lumiere/app/shared/app_controller_store.dart';


class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ThemeService()),
    Bind.lazySingleton((i) => AppControllerStore(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: MoviesModule()),
  ];

}