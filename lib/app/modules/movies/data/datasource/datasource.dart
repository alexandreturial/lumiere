import 'package:lumiere/app/modules/movies/data/models/movie_model.dart';

abstract class IMovieDatasource{
  Future<List<MovieModel?>> searchMovies(int pageNumber, String search);
}