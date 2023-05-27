import 'package:dartz/dartz.dart';
import 'package:lumiere/app/shared/core/errors/Failures.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';
import 'package:lumiere/app/modules/movies/domain/entities/providers.dart';
import 'package:lumiere/app/shared/interfaces/movie.dart';

abstract class IMovieRepository{
  Future<Either<Faliure, List<MovieEntity?>>> getMoviesBySearch(String search, int pageNumber);

  Future<Either<Faliure, List<ProvidersEntity?>>> getMovieProviders(int movieId);

  Future<Either<Faliure, bool>> saveMovieInSchedule(IMovie movie, int date);
}