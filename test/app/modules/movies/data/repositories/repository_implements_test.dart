import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumiere/app/shared/core/errors/Failures.dart';
import 'package:lumiere/app/shared/core/errors/exceptions.dart';
import 'package:lumiere/app/modules/movies/data/datasource/datasource.dart';
import 'package:lumiere/app/modules/movies/data/models/movie_model.dart';
import 'package:lumiere/app/modules/movies/data/repository/repository_implements.dart';
import 'package:mocktail/mocktail.dart';


class MockMovieDatasource extends Mock implements IMovieDatasource{

}


void main() {
  late MovieRepositoryImpl repository;
  late IMovieDatasource datasource;
  
  setUp((){
    datasource = MockMovieDatasource();
    repository = MovieRepositoryImpl(movieDataSource: datasource);
  });

  final movies = [
    const MovieModel(id: 0, name: '', poster: '', date: '',overview: ''),
    const MovieModel(id: 0, name: '', poster: '', date: '',overview: '')
  ];
  

  test('Should return space media model when calls the datasource', 
  () async{

    when(() => datasource.searchMovies(1, '')).thenAnswer(
      (_)  async => movies 
    );

    final result = await repository.getMoviesBySearch('');
    expect(result, Right(movies));
    verify(()=>datasource.searchMovies(1, ''));
  });

  test('Should return a server failure when calls to datasource unsucessful', 
  () async{

    when(() => datasource.searchMovies(1, '')).thenThrow(ServerException());

    final result = await repository.getMoviesBySearch('');
    expect(result, Left(ServerFailure(errorMessage: '')));
    verify(()=>datasource.searchMovies(1, ''));
  });
}