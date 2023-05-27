// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:lumiere/app/shared/interfaces/movie_provider.dart';

class HomeProvidersEntity extends IMovieProvider {
  HomeProvidersEntity(
      {required super.displayPriority,
      required super.logoPath,
      required super.providerId,
      required super.providerName});

  // final int displayPriority;
  // final String logoPath;
  // final int providerId;
  // final String providerName;

  // const HomeProvidersEntity({
  //   required this.displayPriority,
  //   required this.logoPath,
  //   required this.providerId,
  //   required this.providerName,
  // });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayPriority': displayPriority,
      'logoPath': logoPath,
      'providerId': providerId,
      'providerName': providerName,
    };
  }

  @override
  List<Object?> get props =>
      [displayPriority, logoPath, providerId, providerName];
}
