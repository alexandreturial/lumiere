// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:lumiere/app/shared/interfaces/movie_provider.dart';

abstract class IMovie extends Equatable {
  final int id;
  final String name;
  final String poster;
  final String overview;
  final String date;
  final double popularity;
  List<IMovieProvider?> providerList;


  IMovie({
    required this.id,
    required this.name,
    required this.poster,
    required this.overview,
    required this.date,
    required this.popularity,
    required this.providerList,
  });

  IMovie copyWith();

  Map<String, dynamic> toMap();

  @override
  List<Object?> get props => [
    id,
    name,
    poster,
    overview,
    date,
    providerList
  ];
}
