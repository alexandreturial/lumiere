import 'package:flutter/material.dart';

import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/modules/home/domain/repository/home_repository.dart';
import 'package:lumiere/app/modules/home/presenter/states/home_state.dart';
import 'package:intl/intl.dart';
import 'package:lumiere/app/shared/interfaces/movie_provider.dart';

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

  Future<bool> deleteMovieById(int movieId) async {
    var result = await homeRepository.deleteMovieById(movieId);
    return result.fold((faliure) => false, (right) {
      HomeList state = value as HomeList;
      List<HomeMovieEntity> newSteate =
          state.movies.where((movie) => movie.id != movieId).toList();

      state.setMoviesPerDay(newSteate);
      return right;
    });
  }

  Future<bool> viewerMovie(int movieId) async {
    var result = await homeRepository.viewerMovie(movieId);
    return result.fold((faliure) => false, (right) {
      HomeList state = value as HomeList;
      List<HomeMovieEntity> newSteate = state.movies.map((movie) {
        if (movie.id != movieId) {
          movie.hasViewer = true;
        }
        return movie;
      }).toList();

      state.setMoviesPerDay(newSteate);

      return right;
    });
  }

  sertMoviesAtCalendar(DateTime date) {
    List<HomeMovieEntity> movies = loadMovies(date);
    value = HomeList(movies: movies, selectedDay: date);
  }

  showMoviesPerDay(DateTime date) {
    List<HomeMovieEntity> movies = loadMovies(date);
    if (value is HomeList) {
      HomeList oldState = value as HomeList;
      oldState.selectedDay = date;
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
    } else {
      return [];
    }
  }

  getProvidersByMonth() {
    int currentDate = DateTime.now().month;
    List<IMovieProvider?> moviesCurrentMonth = [];

    if (value is HomeList) {
      HomeList oldState = value as HomeList;

      for (var movie in oldState.movies) {
        DateTime date = DateTime.fromMicrosecondsSinceEpoch(movie.dateSaved * 1000);
        if (date.month == currentDate) {
          for (var provider in movie.providerList) {
            if (!oldState.moviesCurrentMonth.contains(provider)) {
              moviesCurrentMonth.add(provider!);
            }
          }
        }
      }

      oldState.setIMovieProvider(moviesCurrentMonth);
    }
  }

  
}
