import 'package:flutter/foundation.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';
import 'package:lumiere/app/modules/movies/domain/repository/movie_repository.dart';

class MovieDetailBloc extends ValueNotifier<MovieEntity> {
  final IMovieRepository movieRepository;
  

  MovieDetailBloc({required this.movieRepository}) : super(MovieEntity(
    id: 0, name: '', poster: '', overview: '', date: ''));

  setMovie(MovieEntity movieSelected){
    //emit(movieSelected);
  }

  Future<void> getMovieProvider(MovieEntity movieSelected, int movieIndex) async{
    final result = await movieRepository.getMovieProviders(movieIndex);

    result.fold(
      (err) => (){}, 
      (success){
        movieSelected.providerList = success;
        value = movieSelected;
      }
    );
  }
}

