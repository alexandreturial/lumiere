import 'dart:convert';

import 'package:lumiere/app/shared/database/adapter_database.dart';
import 'package:lumiere/app/shared/database/realm_database/models/movie_model.dart';
import 'package:realm/realm.dart';


class LumiereDatabaseImpl implements LumiereDatabase {
  final Realm realm;

  LumiereDatabaseImpl({
    required this.realm,
  });

  @override
  List<MovieModel> getAllMovie() {
    return realm.all<MovieModel>().toList();
  }

  @override
  void addMovie(int date, Map<String, dynamic> movie) {
    realm.write(() {
      realm.add(MovieModel(date, _encodeMovie(movie)));
    });
   
  }

  @override
  void editDate(int date, int movieId) {
    List<MovieModel> movies = getAllMovie();
    final movie = movies.where((movie){
      Map<String, dynamic> json = _decodeMovie(movie.movie);
      return json['id'] == movieId;
    }).first;

    realm.write((){
      movie.date = date;
    });
  }

  @override
  void removeMovie(int movieId) {
    List<MovieModel> movies = getAllMovie();

    List<MovieModel> movieSelected = movies.where((movie){
      Map<String, dynamic> json = _decodeMovie(movie.movie);
      return json['id'] == movieId;
    }).toList();


    if(movieSelected.isNotEmpty){
      realm.write(() {
        realm.delete<MovieModel>(movieSelected.first);
      });
    }
  }

  Map<String, dynamic> _decodeMovie(String movie){
    return jsonDecode(movie);
  }

  String  _encodeMovie(Map<String, dynamic> movie){
    return jsonEncode(movie);
  }
  
  @override
  void removeAllMovies() {
    realm.write(() {
      realm.deleteAll<MovieModel>();
    });
  }
  
  @override
  void mediaWatched(int movieId) {
    List<MovieModel> movies = getAllMovie();


    realm.write((){
        List<MovieModel> movieFormated = movies.map((data){
          Map<String, dynamic> json = _decodeMovie(data.movie);
          if(json['id'] == movieId){
            json['hasViewer'] = true;
          }
          data.movie = _encodeMovie(json);
          print(data);
          return data;
        }).toList();
    });
  }

}
