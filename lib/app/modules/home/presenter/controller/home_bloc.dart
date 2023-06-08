import 'package:flutter/cupertino.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/modules/home/domain/repository/home_repository.dart';
import 'package:lumiere/app/modules/home/presenter/states/home_state.dart';
import 'package:intl/intl.dart';

class HomeBloc extends ValueNotifier<HomeStates> {
  final IHomeMovieRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(InitialState());

  Future<void> getAllMoviesSaved() async {
    var result = await homeRepository.getAllMoviesSaved();
    
    result.fold((err) {
      value = ErrorState(erro: err);
    }, (success) {
      value = HomeList(movies: success, selectedDay: DateTime.now());
    });
  }

  Future<void> deleteMovieById(int movieId)  async {
    var result = await homeRepository.deleteMovieById(movieId);
   
  }

  Future<void> viewerMovie(int movieId)  async {
    var result = await homeRepository.viewerMovie(movieId);
   
  }

  sertMoviesAtCalendar(DateTime date){
    List<HomeMovieEntity> movies = loadMovies(date);
    value = HomeList(movies: movies, selectedDay:date);
  }

  showMoviesPerDay(DateTime date){
    List<HomeMovieEntity> movies = loadMovies(date);
    if(value is HomeList){
      HomeList oldState = value as HomeList;
      oldState.setMoviesPerDay(movies);
      value = oldState;
    }
    
  }

  List<HomeMovieEntity> loadMovies(DateTime date) {
    if (value is HomeList) {

      HomeList teste = value as HomeList;
      
      var result = teste.movies.where((filme) {
        var dateMovie = DateTime.fromMillisecondsSinceEpoch(filme.dateSaved);
        var dateFormated = DateFormat("dd-MM-yyyy").format(date);
        var dateMovieFormated = DateFormat("dd-MM-yyyy").format(dateMovie);

        return dateFormated == dateMovieFormated;
      }).toList();
      return result;
    }else{
      return [];
    }
  }

}
