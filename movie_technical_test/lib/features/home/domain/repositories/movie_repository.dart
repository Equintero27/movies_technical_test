import 'package:movie_technical_test/features/home/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getPopularMovies();
}