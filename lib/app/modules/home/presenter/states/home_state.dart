// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/modules/movies/domain/entities/providers.dart';
import 'package:lumiere/app/shared/core/errors/Failures.dart';
import 'package:lumiere/app/shared/interfaces/movie_provider.dart';

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
  List<IMovieProvider?> moviesCurrentMonth;
  bool isLoadingMore = false;
  DateTime selectedDay;

  HomeList({
    required this.movies,
    required this.selectedDay,
    this.moviesCurrentMonth = const [],
    this.moviesPerDay = const [],
  });

  void setMoviesPerDay(List<HomeMovieEntity> movies){
    moviesPerDay = movies;
  }

  void setIMovieProvider(List<IMovieProvider?> providers){
    moviesCurrentMonth = providers;
  }

  void setLoading(){
    isLoadingMore = true;
  }


  List<HomeMovieEntity> getMovieByViwer(bool isViwer){
    return moviesPerDay.where((movie) => movie.hasViewer == isViwer).toList();
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
