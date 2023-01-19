import 'package:dartz/dartz.dart';
import 'package:lumiere/app/core/errors/Failures.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';

abstract class IMovieRepository{
Future<Either<Faliure, List<MovieEntity?>>> getMoviesBySearch(String search);
}