import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/core/http_client/dio_client_implementation.dart';
import 'package:lumiere/app/modules/movies/data/datasource/datasource_implementation.dart';
import 'package:lumiere/app/modules/movies/data/repository/repository_implements.dart';
import 'package:lumiere/app/modules/movies/presenter/detailMovie/movie_detail_bloc.dart';
import 'package:lumiere/app/modules/movies/presenter/movies_bloc.dart';
import 'package:lumiere/app/modules/movies/presenter/movies_page.dart';
import 'package:lumiere/app/modules/movies/presenter/detailMovie/movies_detail.dart';

class MoviesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DioClientImplementation()),
    Bind.lazySingleton((i) => MovieDatasourceImplementation(client: i.get())),
    Bind.lazySingleton((i) => MovieRepositoryImpl(movieDataSource: i.get())),
    Bind.lazySingleton((i) => MoviesBloc(movieRepository: i.get())),
    Bind.lazySingleton((i) => MovieDetailBloc(movieRepository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const MoviesPage()),
    ChildRoute('/detail',
        child: (_, args) => MovieDetail(
          movies: args.data[0],
          selectedIndex: args.data[1],
        ),
        transition: TransitionType.fadeIn,
        duration: const Duration(seconds: 2)
        ),
  ];
}
