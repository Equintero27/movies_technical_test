import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_technical_test/core/network/connectivity_service.dart';
import 'package:movie_technical_test/features/home/domain/entities/movie_entity.dart';
import 'package:movie_technical_test/features/home/domain/usescases/get_popular_movies_usescase.dart';
import 'package:movie_technical_test/features/home/presentation/cubit/home_cubit.dart';
import 'package:movie_technical_test/features/home/presentation/cubit/home_state.dart';

class MockGetPopularMovies extends Mock implements GetPopularMoviesUsescase {}
class MockConnectivityService extends Mock implements ConnectivityService {}

void main() {

  late HomeCubit cubit;
  late MockGetPopularMovies usecase;
  late MockConnectivityService connectivity;

  setUp(() {
    usecase = MockGetPopularMovies();
    connectivity = MockConnectivityService();
    cubit = HomeCubit(usecase, connectivity);
  });

  final movies = [
    MovieEntity(
      id: 1,
      title: 'Batman',
      posterPath: '/batman.jpg',
      overview: 'Popular movie',
      releaseDate: '09/05/2023',
      voteAverage: 2.9,
    )
  ];

  blocTest<HomeCubit, HomeState>(
    'emits [Loading, Loaded] when fetchMovies is successful',
    build: () {
      when(() => usecase()).thenAnswer((_) async => movies);
      when(() => connectivity.hasInternet()).thenAnswer((_) async => true);
      return cubit;
    },
    act: (cubit) => cubit.fetchMovies(),
    expect: () => [
      isA<HomeLoading>(),
      isA<HomeLoaded>(),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'emits [Loading, Error] when fetchMovies fails',
    build: () {
      when(() => usecase()).thenThrow(Exception());
      return cubit;
    },
    act: (cubit) => cubit.fetchMovies(),
    expect: () => [
      isA<HomeLoading>(),
      isA<HomeError>(),
    ],
  );
}