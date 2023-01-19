import 'package:lumiere/app/core/errors/Failures.dart';
import 'package:dartz/dartz.dart';
import 'package:lumiere/app/core/errors/exceptions.dart';
import 'package:lumiere/app/modules/movies/data/datasource/datasource.dart';
import 'package:lumiere/app/modules/movies/domain/entities/movie.dart';
import 'package:lumiere/app/modules/movies/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements IMovieRepository {
  final IMovieDatasource movieDataSource;

  MovieRepositoryImpl({
    required this.movieDataSource,
  });

  @override
  Future<Either<Faliure, List<MovieEntity?>>> getMoviesBySearch(String search) async{
     try {
      final result = await movieDataSource.searchMovies(1, search);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(errorMessage: ''));
    } catch (e) {
      return Left(ServerFailure(
        errorCode: 401,
        errorMessage: 'Erro ao conectar ao servidor'
      ));
    }
  }

}