import 'package:lumiere/app/modules/movies/data/models/movie_model.dart';
import 'package:lumiere/app/modules/movies/data/models/provider_model.dart';

abstract class IMovieDatasource{
  Future<List<MovieModel?>> searchMovies(int pageNumber, String search);

  Future<List<ProvidersModel?>> movieWatchProviders(int movieId);

  Future<bool> saveMovieInSchedule(Map<String, dynamic> movie, int date);
}