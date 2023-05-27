// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class IMovieProvider extends Equatable {
  final int displayPriority;
  final String logoPath;
  final int providerId;
  final String providerName;

  IMovieProvider({
    required this.displayPriority,
    required this.logoPath,
    required this.providerId,
    required this.providerName,
  });

  Map<String, dynamic> toMap();

  @override
  List<Object?> get props =>
      [displayPriority, logoPath, providerId, providerName];
}
