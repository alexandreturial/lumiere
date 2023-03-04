// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProvidersEntity extends Equatable {
  final int displayPriority;
  final String logoPath;
  final int providerId; 
  final String providerName;


  const ProvidersEntity({
    required this.displayPriority,
    required this.logoPath,
    required this.providerId,
    required this.providerName, 
  });

  @override
  List<Object?> get props => [
    displayPriority,
    logoPath,
    providerId,
    providerName
  ];

}