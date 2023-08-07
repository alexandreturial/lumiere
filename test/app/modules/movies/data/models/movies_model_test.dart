import 'package:flutter_test/flutter_test.dart';
import 'package:lumiere/app/modules/movies/data/models/movie_model.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';


void main() {
  MovieModel movieModel = const MovieModel(id: 0, name: '', poster: '', date: '',overview: '');
  

  test('should be a subclass of MovieEntity',(){
    expect(movieModel, isA<MovieEntity>());
  });
 
}