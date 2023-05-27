
import 'package:lumiere/app/modules/home/domain/entities/movie_provider_entity.dart';

class HomeProvidersModel extends HomeProvidersEntity{
  HomeProvidersModel({required super.displayPriority, required super.logoPath, required super.providerId, required super.providerName});

  factory HomeProvidersModel.fromJson(Map<String, dynamic> json){   
    return HomeProvidersModel(
      displayPriority: json['displayPriority'] ?? '',
      logoPath: json['logoPath'] ?? '',
      providerId: json['providerId'] ?? 0,
      providerName: json['providerName'] ?? '',
    );

  }
}