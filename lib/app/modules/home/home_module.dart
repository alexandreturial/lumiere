import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/modules/home/counter_cubit.dart';
import 'package:lumiere/app/modules/home/home_page.dart';
class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CounterCubit()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => HomePage()),
  ];
}