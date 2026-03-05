import 'package:movie_technical_test/features/home/domain/entities/movie_entity.dart';
import 'package:movie_technical_test/features/home/domain/repositories/movie_repository.dart';

class GetPopularMoviesUsescase {
  final MovieRepository repository;

  GetPopularMoviesUsescase(this.repository);

  Future<List<MovieEntity>> call() async {
    return await repository.getPopularMovies();
  }
}