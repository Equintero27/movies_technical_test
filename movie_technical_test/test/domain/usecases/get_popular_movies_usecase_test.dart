import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_technical_test/features/home/domain/entities/movie_entity.dart';
import 'package:movie_technical_test/features/home/domain/repositories/movie_repository.dart';
import 'package:movie_technical_test/features/home/domain/usescases/get_popular_movies_usescase.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetPopularMoviesUsescase usecase;
  late MockMovieRepository repository;

  setUp(() {
    repository = MockMovieRepository();
    usecase = GetPopularMoviesUsescase(repository);
  });

  test('should return list of movies from repository', () async {

    final movies = [
      MovieEntity(id: 1, title: 'Batman', posterPath: '/batman.jpg', overview: 'Popular movie', releaseDate: '09/05/2023',voteAverage: 2.9,)
    ];

    when(() => repository.getPopularMovies())
        .thenAnswer((_) async => movies);

    final result = await usecase();

    expect(result, movies);

    verify(() => repository.getPopularMovies()).called(1);
  });
}