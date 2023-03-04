// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lumiere/app/core/errors/Failures.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';

abstract class MoviesStates{}


class InitialState extends MoviesStates {
}

class MoviesList extends MoviesStates {
  final List<MovieEntity?> movies;

  MoviesList({
    required this.movies,
  });
}


class EmptyState extends MoviesStates {
}


class ErrorState extends MoviesStates {
  final Faliure erro;

  ErrorState({
    required this.erro,
  });  
}
