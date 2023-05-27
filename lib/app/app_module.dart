import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/modules/home/home_module.dart';
import 'package:lumiere/app/shared/core/themes/theme_service.dart';
import 'package:lumiere/app/modules/movies/movies_module.dart';
import 'package:lumiere/app/shared/app_controller_store.dart';
import 'package:lumiere/app/shared/database/adapter_database.dart';
import 'package:lumiere/app/shared/database/realm_database/configuration_database.dart';
import 'package:lumiere/app/shared/database/realm_database/realm_implements.dart';
import 'package:realm/realm.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ThemeService()),
    Bind.lazySingleton((i) => AppControllerStore(i.get())),
    Bind.instance<LumiereDatabase>(LumiereDatabaseImpl(realm: Realm(config))),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/search', module: MoviesModule()),
  ];

}