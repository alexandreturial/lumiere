import 'package:dio/dio.dart';
import 'package:lumiere/app/shared/core/errors/exceptions.dart';
import 'package:lumiere/app/shared/core/http_client/http_client.dart';
import 'package:lumiere/app/modules/movies/data/datasource/datasource.dart';
import 'package:lumiere/app/modules/movies/data/datasource/routes/client.dart';
import 'package:lumiere/app/modules/movies/data/models/movie_model.dart';
import 'package:lumiere/app/modules/movies/data/models/provider_model.dart';
import 'package:lumiere/app/shared/database/adapter_database.dart';

class MovieDatasourceImplementation implements IMovieDatasource {
  final HttpClient client;
  final LumiereDatabase database;

  MovieDatasourceImplementation(
    {
      required this.client,
      required this.database,
    }
  );

  @override
  Future<List<MovieModel?>> searchMovies(int pageNumber, String search) async{
    
    final response = await client.get(
      MovieEndPoints.searchMovie(pageNumber: pageNumber, search: search),
      Options()
    );    


    if( response.statusCode == 200 ){
      var content = response.data['results'] as List;
      
      return content.map((item) => MovieModel.fromJson(item)).toList();
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<ProvidersModel?>> movieWatchProviders(int movieId) async{
    final response = await client.get(
      MovieEndPoints.movieWatchProviders(movieId: movieId),
      Options()
    );    
    if( response.statusCode == 200 ){
      var content = response.data['results']['AR']['flatrate'] as List;
      //print(content);
      
      return content.map((item) => ProvidersModel.fromJson(item)).toList();
    }else{
      throw ServerException();
    }
  }
  
  @override
  Future<bool> saveMovieInSchedule(Map<String, dynamic> movie, int date) async{
    try {
      database.addMovie(date, movie);
      return true;
    } catch (e) {
      print(e);
      
      rethrow;
    }
   
  }

}