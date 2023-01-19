import 'package:dio/dio.dart';
import 'package:lumiere/app/core/errors/exceptions.dart';
import 'package:lumiere/app/core/http_client/http_client.dart';
import 'package:lumiere/app/modules/movies/data/datasource/datasource.dart';
import 'package:lumiere/app/modules/movies/data/datasource/routes/client.dart';
import 'package:lumiere/app/modules/movies/data/models/movie_model.dart';

class MovieDatasourceImplementation implements IMovieDatasource {
  final HttpClient client;

  MovieDatasourceImplementation(
    {
      required this.client,
    }
  );

  @override
  Future<List<MovieModel?>> searchMovies(int pageNumber, String search) async{
    
    final response = await client.get(
      MovieEndPoints.searchMovie(pageNumber: pageNumber, query: search),
      Options()
    );    
    if( response.statusCode == 200 ){
      var content = response.data['results'] as List;
      return content.map((item) => MovieModel.fromJson(item)).toList();
    }else{
      throw ServerException();
    }
  }

}