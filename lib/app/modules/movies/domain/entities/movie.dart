// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lumiere/app/shared/interfaces/movie.dart';
import 'package:lumiere/app/shared/interfaces/movie_provider.dart';

class MovieEntity extends IMovie {
  List<IMovieProvider?> provider;
  MovieEntity(
      {required super.id,
      required super.name,
      required super.poster,
      required super.overview,
      required super.date,
      required super.popularity,
      required this.provider}) : super(providerList: provider);

  // final int id;
  // final String name;
  // final String poster;
  // final String overview;
  // final String date;
  // final double popularity;
  // List<ProvidersEntity?> providerList;

  // MovieEntity({
  //   required this.id,
  //   required this.name,
  //   required this.poster,
  //   required this.overview,
  //   required this.date,
  //   this.popularity = 1.0,
  //   this.providerList = const []
  // });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'poster': poster,
      'overview': overview,
      'hasViewer': false,
      'date': date,
      'popularity': popularity,
      'providerList':
          providerList.map((provider) => provider?.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, name, poster, overview, date, providerList];

  MovieEntity copyWith({
    int? id,
    String? name,
    String? poster,
    String? overview,
    String? date,
    double? popularity,
    List<IMovieProvider?>? providerList,
  }) {
    return MovieEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      poster: poster ?? this.poster,
      overview: overview ?? this.overview,
      date: date ?? this.date,
      popularity: this.popularity,
      provider: providerList ?? this.providerList,
    );
  }
}
