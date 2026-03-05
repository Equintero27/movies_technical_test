import 'package:movie_technical_test/features/home/data/datasources/movie_remote_datasource.dart';
import 'package:movie_technical_test/features/home/domain/entities/movie_entity.dart';
import 'package:movie_technical_test/features/home/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository{
  final MovieRemoteDatasource remoteDatasource;

  MovieRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<MovieEntity>> getPopularMovies() async {
    return await remoteDatasource.getPopularMovies();
  }
}