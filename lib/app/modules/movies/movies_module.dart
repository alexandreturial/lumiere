import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/core/http_client/http_client_implementation.dart';
import 'package:lumiere/app/modules/movies/data/datasource/datasource_implementation.dart';
import 'package:lumiere/app/modules/movies/data/repository/repository_implements.dart';
import 'package:lumiere/app/modules/movies/presenter/movies_bloc.dart';
import 'package:lumiere/app/modules/movies/presenter/movies_page.dart';

class MoviesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HttpClientImplementation()),
    Bind.lazySingleton((i) => MovieDatasourceImplementation(client: i.get())),
    Bind.lazySingleton((i) => MovieRepositoryImpl(movieDataSource: i.get())),
    Bind.lazySingleton((i) => MoviesBloc(movieRepository: i.get() )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MoviesPage()),
  ];
}
