
import 'package:lumiere/app/shared/models/enviromant.dart';

class MovieEndPoints {

  static String searchMovie({required int pageNumber, required String search}) =>
      'https://api.themoviedb.org/3/search/movie?api_key=${Enviroment.apiKey}&language=pt-Br&query=$search&page=$pageNumber&include_adult=false';
  
   static String movieWatchProviders({required int movieId}) =>
      'https://api.themoviedb.org/3/movie/$movieId/watch/providers?api_key=${Enviroment.apiKey}';
}
