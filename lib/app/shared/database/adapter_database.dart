import 'package:lumiere/app/shared/database/realm_database/models/movie_model.dart';

abstract class LumiereDatabase {
  List<MovieModel> getAllMovie();

  void addMovie(int date, Map<String, dynamic> movie);

  void editDate(int date, int movieId);

  void mediaWatched(int movieId);

  void removeMovie(int movieId);

  void removeAllMovies();
}
