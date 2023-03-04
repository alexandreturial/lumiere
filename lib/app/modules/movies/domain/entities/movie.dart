// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:lumiere/app/modules/movies/domain/entities/providers.dart';

class MovieEntity extends Equatable {
  final int id;
  final String name;
  final String poster;
  final String overview;
  final String date;
  List<ProvidersEntity?> providerList;

  MovieEntity({
    required this.id,
    required this.name,
    required this.poster,
    required this.overview, 
    required this.date, 
    this.providerList = const []
  });

  @override
  List<Object?> get props => [
    id,
    name,
    poster,
    overview,
    date,
    providerList
  ];


  MovieEntity copyWith({
    int? id,
    String? name,
    String? poster,
    String? overview,
    String? date,
    List<ProvidersEntity?>? providerList,
  }) {
    return MovieEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      poster: poster ?? this.poster,
      overview: overview ?? this.overview,
      date: date ?? this.date,
      providerList: providerList ?? this.providerList,
    );
  }
}
