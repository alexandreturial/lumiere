// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

abstract class Faliure extends Equatable{

}


class ServerFailure extends Faliure {
  final int errorCode;
  final String errorMessage;
  
  ServerFailure({
    this.errorCode = 0, 
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [
    errorCode,
    errorMessage
  ];


}

class NullParamFailure extends Faliure{
  @override
  List<Object?> get props => [];
}

class UserDataWrong extends Faliure {
  final String message;

  UserDataWrong({
    required this.message,
  });
  
  @override
  List<Object?> get props => [
    message
  ];


}
