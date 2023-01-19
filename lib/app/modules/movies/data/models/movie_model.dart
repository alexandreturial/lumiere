import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';

class MovieModel extends MovieEntity{
  const MovieModel({required super.id, required super.name, required super.poster});


  factory MovieModel.fromJson(Map<String, dynamic> json){    
    return MovieModel(
      id: json['id'],
      name: json['title'] ?? '',
      poster: json['poster_path'] ?? '',
    );
  }
}