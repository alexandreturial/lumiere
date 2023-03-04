import 'package:flutter/cupertino.dart';
import 'package:lumiere/app/modules/movies/domain/repository/movie_repository.dart';
import 'package:lumiere/app/modules/movies/presenter/movies_state.dart';

class MoviesBloc extends ValueNotifier<MoviesStates> {
  final IMovieRepository movieRepository;

  MoviesBloc({required this.movieRepository}) : super(InitialState());


  Future<void> searchMovies(String search) async{
    
    final result = await movieRepository.getMoviesBySearch(search);
    result.fold(
      (faliue){
        value = ErrorState(erro: faliue);
      }, 
      (success){
        print(success.length);
        if(success.isEmpty){
          value = EmptyState();
        }else{
          value = MoviesList(movies: success);
        }
      }
    );
  }

  Future<void> getMovieProvider(int movieIndex) async{
    //final result = await movieRepository.getMovieProviders(value[movieIndex]!.id);

    // result.fold(
    //   (err) => emit(state), 
    //   (success){
    //      state[movieIndex]!.providerList = success;
        
    //     emit(state);
    //   }
    // );
  }
}