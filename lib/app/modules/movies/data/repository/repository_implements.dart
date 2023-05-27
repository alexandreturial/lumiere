import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lumiere/app/shared/core/errors/Failures.dart';
import 'package:dartz/dartz.dart';
import 'package:lumiere/app/shared/core/errors/exceptions.dart';
import 'package:lumiere/app/modules/movies/data/datasource/datasource.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';
import 'package:lumiere/app/modules/movies/domain/entities/providers.dart';
import 'package:lumiere/app/modules/movies/domain/repository/movie_repository.dart';
import 'package:lumiere/app/shared/interfaces/movie.dart';

class MovieRepositoryImpl implements IMovieRepository {
  final IMovieDatasource movieDataSource;

  MovieRepositoryImpl({
    required this.movieDataSource,
  });

  @override
  Future<Either<Faliure, List<MovieEntity?>>> getMoviesBySearch(String search, int pageNumber) async{

    try {
      final result = await movieDataSource.searchMovies(pageNumber, search);
      return Right(result);
    } on DioError catch (e) {
      return Left(ServerFailure(errorCode: 400,errorMessage: 'errro ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(
        errorCode: 401,
        errorMessage: 'Erro ao conectar ao servidor'
      ));
    }
  }

  @override
  Future<Either<Faliure, List<ProvidersEntity?>>> getMovieProviders(int movieId) async{

    try {
      final result = await movieDataSource.movieWatchProviders(movieId);
      return Right(result);
    } on DioError catch (e) {
       return Left(ServerFailure(errorCode: 400,errorMessage: 'errro ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(
        errorCode: 401,
        errorMessage: 'Erro ao conectar ao servidor'
      ));
    }
  }
  
  @override
  Future<Either<Faliure, bool>> saveMovieInSchedule(IMovie movie, int date) async{
    try {
      final result = await movieDataSource.saveMovieInSchedule(movie.toMap(), date);
      return Right(result);
    } on DioError catch (e) {
       return Left(ServerFailure(errorCode: 400,errorMessage: 'errro ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(
        errorCode: 401,
        errorMessage: 'Erro ao conectar ao servidor'
      ));
    }
  }

}