// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lumiere/app/shared/core/errors/Failures.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';

abstract class MoviesStates{}


class InitialState extends MoviesStates {
}

class LoadingState extends MoviesStates {
}


class LoadingMoreMovies extends MoviesStates {
  final List<MovieEntity?> movies;

  LoadingMoreMovies({
    required this.movies,
  });
}


class MoviesList extends MoviesStates {
  final List<MovieEntity?> movies;
  bool isLoadingMore = false;

  MoviesList({
    required this.movies,
  });

  void setLoading(){
    isLoadingMore = true;
  }
  
}


class EmptyState extends MoviesStates {
}


class ErrorState extends MoviesStates {
  final Faliure erro;

  ErrorState({
    required this.erro,
  });  
}
