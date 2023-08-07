import 'package:lumiere/app/modules/home/data/datasource/datasource.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:lumiere/app/modules/home/domain/repository/home_repository.dart';
import 'package:lumiere/app/shared/core/errors/Failures.dart';

class HomeRepositoryImpl implements IHomeMovieRepository {
  final IHomeMovieDatasource homeMovieDataSource;

  HomeRepositoryImpl({
    required this.homeMovieDataSource,
  });

  @override
  Future<Either<Faliure, List<HomeMovieEntity>>> getAllMoviesSaved() async {
    
    try {
      return Right(await homeMovieDataSource.getAllMoviesSaved());
    } catch (e) {
      return Left(
        ServerFailure(
          errorCode: 401,
          errorMessage: 'Erro ao conectar ao servidor',
        ),
      );
    }
  }
  
  @override
  Future<Either<Faliure, bool>> deleteMovieById(int movieId) async{

    try {
      return Right(await homeMovieDataSource.deleteMovieById(movieId));
    } catch (e) {
      return Left(
        ServerFailure(
          errorCode: 401,
          errorMessage: 'Erro ao conectar ao servidor',
        ),
      );
    }
  }
  
  @override
  Future<Either<Faliure, bool>> viewerMovie(int movieId) async{
    try {
      return Right(await homeMovieDataSource.viewerMovie(movieId));
    } catch (e) {
      return Left(
        ServerFailure(
          errorCode: 401,
          errorMessage: 'Erro ao conectar ao servidor',
        ),
      );
    }
  }
}
