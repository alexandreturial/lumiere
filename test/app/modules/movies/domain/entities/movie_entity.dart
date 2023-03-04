import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';
import 'package:lumiere/app/core/errors/Failures.dart';
import 'package:lumiere/app/modules/movies/domain/repository/movie_repository.dart';
import 'package:lumiere/app/modules/movies/presenter/movies_bloc.dart';


class TestMovie extends IMovieRepository {
  @override
  Future<Either<Faliure, List<MovieEntity?>>> getMoviesBySearch(String search) {
    return Future.value(const Right([ MovieEntity(id: 0, name: '', poster: '', date: '', overview: '')]));
  }

}
 
void main() {

  blocTest<MoviesBloc, List<MovieEntity?>>('emits [1] when increment is added',
    build: () => MoviesBloc(movieRepository: TestMovie()),
    act: (bloc) => bloc.searchMovies(''),
    expect: () => [3],
    
  );
}