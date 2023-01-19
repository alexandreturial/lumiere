import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/modules/movies/movies_module.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: MoviesModule()),
  ];

}