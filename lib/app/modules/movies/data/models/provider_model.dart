
import 'package:lumiere/app/modules/movies/domain/entities/providers.dart';

class ProvidersModel extends ProvidersEntity{
  const ProvidersModel({required super.displayPriority, required super.logoPath, required super.providerId, required super.providerName});
 


  factory ProvidersModel.fromJson(Map<String, dynamic> json){    
    return ProvidersModel(
      displayPriority: json['display_priority'] ?? '',
      logoPath: json['logo_path'] ?? '',
      providerId: json['provider_id'] ?? 0,
      providerName: json['provider_name'] ?? '',
    );

  }
}