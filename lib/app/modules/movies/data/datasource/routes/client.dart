import 'package:lumiere/app/shared/models/enviromant.dart';

class MovieEndPoints {
  static String searchMovie({required int pageNumber, required String query}) =>
      'https://api.themoviedb.org/3/search/movie?api_key=ece5778e13c936b98163c3e58e4e11a3&language=en-US&query=avengers&page=1&include_adult=false';
}
