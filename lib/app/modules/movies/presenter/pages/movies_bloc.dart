import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:lumiere/app/modules/movies/domain/repository/movie_repository.dart';
import 'package:lumiere/app/modules/movies/presenter/pages/movies_state.dart';

class MoviesBloc extends ValueNotifier<MoviesStates> {
  final IMovieRepository movieRepository; 
  int pageMovieSearch = 1;
  String searchred = "";

  MoviesBloc({required this.movieRepository}) : super(InitialState());


  Future<void> searchMovies(String search) async{
    value = LoadingState();
    pageMovieSearch = 1;
    searchred = search;
    final result = await movieRepository.getMoviesBySearch(search, pageMovieSearch);
    await Future.delayed(const Duration(seconds: 2));
    result.fold(
      (faliue){
        value = ErrorState(erro: faliue);
      }, 
      (success){
        if(success.isEmpty){
          value = EmptyState();
        }else{
          value = MoviesList(movies: success);
          pageMovieSearch += 1;
        }
      }
    );
  }

  Future<void> getMoreMovies() async{
    final MoviesList oldList = value as MoviesList;

    final result = await movieRepository.getMoviesBySearch(searchred, pageMovieSearch);

    result.fold(
      (faliue){
        value = ErrorState(erro: faliue);
      }, 
      (success){
        if(success.isEmpty){
          value = MoviesList(movies: [...oldList.movies]);
        }else{
          value = MoviesList(movies: [...oldList.movies, ...success]);
          pageMovieSearch += 1;

        }
      }
    );
  }

}