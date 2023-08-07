
import 'package:lumiere/app/modules/home/data/models/home_movie_provider_model.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';

class HomeMovieModel extends HomeMovieEntity{
  HomeMovieModel({
    required super.id, 
    required super.name, 
    required super.poster, 
    required super.overview, 
    required super.date, 
    required super.popularity, 
    required super.dateSaved,
    required super.providerList,
    super.hasViewer});

  factory HomeMovieModel.fromJson(Map<String, dynamic> json, int dateSaved){ 
    var providerList = json['providerList'] as List;
    List<HomeProvidersModel?> providers = providerList.map((provider) =>  HomeProvidersModel.fromJson(provider)).toList();
    
    return HomeMovieModel(
      id: json['id'],
      dateSaved: dateSaved ?? 0,
      name: json['name'] ?? '',
      poster: json['poster'] ?? '',
      hasViewer: json['hasViewer']??false,
      date: json['release_date'] ?? '',
      overview: json['overview'] ?? '',
      popularity: json['popularity'] ?? 1,
      providerList: providers
    );

  }
}