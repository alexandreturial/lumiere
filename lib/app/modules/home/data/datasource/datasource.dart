import 'package:lumiere/app/modules/home/data/models/home_movie_model.dart';

abstract class IHomeMovieDatasource{
  Future<List<HomeMovieModel>> getAllMoviesSaved();

  Future<bool> deleteMovieById(int movieId);

  Future<bool> editMovieById(int movieId);

  Future<bool> viewerMovie(int movieId);

}