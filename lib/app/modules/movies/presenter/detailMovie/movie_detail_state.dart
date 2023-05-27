// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lumiere/app/shared/core/errors/Failures.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';
import 'package:lumiere/app/shared/interfaces/movie.dart';

abstract class MovieDetailStates{}


class InitialState extends MovieDetailStates {

}

class LoadingState extends MovieDetailStates {
  
}

class MovieDetailState extends MovieDetailStates {
  final IMovie movie;

  MovieDetailState({
    required this.movie,
  });
}

class EmptyState extends MovieDetailStates {
}

class ErrorProviderState extends MovieDetailStates {
  final Faliure erro;
  final IMovie movie;

  ErrorProviderState({
    required this.erro,
    required this.movie,
  });  
}

class ErrorSaveMovieState extends MovieDetailStates {
  final Faliure erro;

  ErrorSaveMovieState({
    required this.erro,
  });  
}
