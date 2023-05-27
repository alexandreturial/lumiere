// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lumiere/app/modules/home/domain/entities/movie_provider_entity.dart';
import 'package:lumiere/app/shared/interfaces/movie.dart';

class HomeMovieEntity extends IMovie {
  final int dateSaved;
  HomeMovieEntity(
      {required super.id,
      required super.name,
      required super.poster,
      required super.overview,
      required super.date,
      required super.popularity,
      required super.providerList,
      required this.dateSaved});

  // final int id;
  // final int dateSaved;
  // final String name;
  // final String poster;
  // final String overview;
  // final String date;
  // final double popularity;
  // List<HomeProvidersEntity?> providerList;

  // HomeMovieEntity({
  //   required this.id,
  //   required this.dateSaved,
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
      'dateSaved': dateSaved,
      'name': name,
      'poster': poster,
      'overview': overview,
      'date': date,
      'popularity': popularity,
      'providerList': providerList.map((x) => x?.toMap()).toList(),
    };
  }

  @override
  List<Object> get props {
    return [
      id,
      dateSaved,
      name,
      poster,
      overview,
      date,
      popularity,
      providerList,
    ];
  }

  @override
  HomeMovieEntity copyWith({
    int? id,
    int? dateSaved,
    String? name,
    String? poster,
    String? overview,
    String? date,
    double? popularity,
    List<HomeProvidersEntity?>? providerList,
  }) {
    return HomeMovieEntity(
      id: id ?? this.id,
      dateSaved: dateSaved ?? this.dateSaved,
      name: name ?? this.name,
      poster: poster ?? this.poster,
      overview: overview ?? this.overview,
      date: date ?? this.date,
      popularity: popularity ?? this.popularity,
      providerList: providerList ?? this.providerList,
    );
  }
}
