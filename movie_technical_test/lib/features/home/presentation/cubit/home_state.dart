import 'package:movie_technical_test/features/home/domain/entities/movie_entity.dart';

abstract class HomeState {}
class HomeInitial extends HomeState{}

class HomeLoading extends HomeState{}

class HomeLoaded extends HomeState{
  final List <MovieEntity>  movies;

  HomeLoaded(this.movies);
}

class HomeError extends HomeState{
  final String message;

  HomeError(this.message);
}