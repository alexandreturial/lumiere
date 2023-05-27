import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';

class MovieModel extends MovieEntity {
  MovieModel(
      {required super.id,
      required super.name,
      required super.poster,
      required super.overview,
      required super.date,
      required super.popularity, 
      required super.provider});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      name: json['title'] ?? '',
      poster: json['poster_path'] ?? '',
      date: json['release_date'] ?? '',
      overview: json['overview'] ?? '',
      popularity: json['vote_average'] ?? 1,
      provider: const [],
    );
  }
}
