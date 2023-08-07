import 'dart:convert';

import 'package:lumiere/app/modules/home/data/datasource/datasource.dart';
import 'package:lumiere/app/modules/home/data/models/home_movie_model.dart';
import 'package:lumiere/app/shared/database/adapter_database.dart';

class HomeMovieDatasourceImplementation implements IHomeMovieDatasource {
  final LumiereDatabase database;

  HomeMovieDatasourceImplementation({
    required this.database,
  });

  @override
  Future<List<HomeMovieModel>> getAllMoviesSaved() async {
    
    var filmes = database.getAllMovie();
    
    List<HomeMovieModel> moviesConverted = filmes.map(
      (filme) => HomeMovieModel.fromJson(
        jsonDecode(filme.movie), filme.date 
      ),
    ).toList();

    
    return moviesConverted;
  }
  
  @override
  Future<bool> deleteMovieById(int movieId) {
    database.removeMovie(movieId);

    return Future.value(true);
  }
  
  @override
  Future<bool> editMovieById(int movieId) {
    database.mediaWatched(movieId);
    return Future.value(true);
  }
  
  @override
  Future<bool> viewerMovie(int movieId) {
    database.mediaWatched(movieId);

    return Future.value(false);
  }
}
