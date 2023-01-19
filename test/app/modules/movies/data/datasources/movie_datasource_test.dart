
import 'package:flutter_test/flutter_test.dart';
import 'package:lumiere/app/core/errors/exceptions.dart';
import 'package:lumiere/app/core/http_client/http_client.dart';
import 'package:lumiere/app/modules/movies/data/datasource/datasource.dart';
import 'package:lumiere/app/modules/movies/data/datasource/datasource_implementation.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/search_movies.dart';


class HttpClientMocking extends Mock implements HttpClient{
  
}


void main() {
  late IMovieDatasource datasource;
  late HttpClient client;

  setUp(() async{
    client = HttpClientMocking();
    datasource = MovieDatasourceImplementation(client: client);
    
  });

  const String baseUrl = 'https://api.themoviedb.org/3/search/movie?api_key=ece5778e13c936b98163c3e58e4e11a3&language=en-US&query=avengers&page=1&include_adult=false';

  

  successMock(){
    
    when(() => client.get(any(), any())).thenAnswer(
      (_) async =>  HttpResponse(data: movies, statusCode: 200)
    );
  }

  test('should call the search movies with correct url',() async{

    successMock();

    await datasource.searchMovies(1, '');
    verify(() => client.get(baseUrl, any())).called(1);
  });

  test('should return a List Movie Model when is successfull',() async{

    successMock();

    final result = await datasource.searchMovies(1, '');
    
    expect(result, moviesModel);
  });

  test('should return throw a ServerException when the update is unccessuful',() async{
    when(() => client.get(baseUrl,  any())).thenAnswer(
      (_) async => HttpResponse(data: "Somenthing went wrong", statusCode: 400)
    );

    final result = datasource.searchMovies(1, '');
    
    expect(() => result, throwsA(ServerException()));
  });
} 