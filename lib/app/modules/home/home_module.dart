import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/modules/home/data/datasource/datasource_implementation.dart';
import 'package:lumiere/app/modules/home/data/repository/home_repository.dart';
import 'package:lumiere/app/modules/home/presenter/page/home_page.dart';
import 'package:lumiere/app/modules/home/presenter/controller/home_bloc.dart';


class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeMovieDatasourceImplementation(database: i.get())),
    Bind.lazySingleton((i) => HomeRepositoryImpl(homeMovieDataSource: i.get())),
    Bind.lazySingleton((i) => HomeBloc(homeRepository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => const HomePage()),
  ];
}