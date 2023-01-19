import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';
import 'package:lumiere/app/modules/movies/domain/repository/movie_repository.dart';

class MoviesBloc extends Cubit<List<MovieEntity?>> {
  final IMovieRepository movieRepository;

  MoviesBloc({required this.movieRepository}) : super([]);


  Future<void> searchMovies(String search) async{
    final result = await movieRepository.getMoviesBySearch(search);
    print(result);
    result.fold(
      (err) => emit(state), 
      (success){
        emit([...state, ...success]);
      }
    );
  }
}