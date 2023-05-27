// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/shared/core/errors/Failures.dart';

abstract class HomeStates{}


class InitialState extends HomeStates {
}

class LoadingState extends HomeStates {
}


class LoadingMoreHome extends HomeStates {
  final List<HomeMovieEntity?> movies;

  LoadingMoreHome({
    required this.movies,
  });
}


class HomeList extends HomeStates {
  final List<HomeMovieEntity> movies;
  List<HomeMovieEntity> moviesPerDay;
  bool isLoadingMore = false;
  DateTime selectedDay;

  HomeList({
    required this.movies,
    required this.selectedDay,
    this.moviesPerDay = const [],
  });

  void setMoviesPerDay(List<HomeMovieEntity> movies){
    moviesPerDay = movies;
  }

  void setLoading(){
    isLoadingMore = true;
  }
  
}


class EmptyState extends HomeStates {
}


class ErrorState extends HomeStates {
  final Faliure erro;

  ErrorState({
    required this.erro,
  });  
}
