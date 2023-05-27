import 'package:flutter/cupertino.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';
import 'package:lumiere/app/modules/movies/domain/repository/movie_repository.dart';
import 'package:lumiere/app/modules/movies/presenter/detailMovie/movie_detail_state.dart';
import 'package:intl/intl.dart';
import 'package:lumiere/app/shared/interfaces/movie.dart';

class MovieDetailBloc extends ValueNotifier<MovieDetailStates> {
  final IMovieRepository movieRepository;
  TextEditingController dateinput = TextEditingController();
  int dateinputTimestamp = 0;

  MovieDetailBloc({required this.movieRepository}) : super(InitialState());

  void setMovie(IMovie movieSelected) {
    value = MovieDetailState(movie: movieSelected);
  }

  void setDate(DateTime timestamp) {
    dateinput.text = DateFormat('dd/MM/yyyy').format(timestamp);
    dateinputTimestamp = timestamp.millisecondsSinceEpoch;
  }

  Future<void> getMovieProvider(int movieIndex) async {
    if (value is MovieDetailState) {
      final MovieDetailState movieSelected = value as MovieDetailState;
      value = LoadingState();

      final result = await movieRepository.getMovieProviders(movieIndex);

      result.fold((err) {
        value = ErrorProviderState(erro: err, movie: movieSelected.movie);
      }, (success) {
        movieSelected.movie.providerList = success;
        value = movieSelected;
      });
    }
  }

  Future<bool> saveMovieInSchedule(IMovie movieSelected) async {
    final result = await movieRepository.saveMovieInSchedule(movieSelected, dateinputTimestamp);

    return result.fold(
      (error) {
        value = ErrorSaveMovieState(erro: error);
        return false;
      },
      (succeeded) {
        return true;
      },
    );
  }

  
}
