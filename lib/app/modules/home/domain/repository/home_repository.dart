import 'package:dartz/dartz.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/shared/core/errors/Failures.dart';

abstract class IHomeMovieRepository{
  Future<Either<Faliure, List<HomeMovieEntity>>> getAllMoviesSaved();

  Future<Either<Faliure, bool>> deleteMovieById(int movieId);

  Future<Either<Faliure, bool>> viewerMovie(int movieId);
}