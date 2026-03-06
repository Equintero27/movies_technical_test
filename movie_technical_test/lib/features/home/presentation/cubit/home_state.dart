import 'package:movie_technical_test/features/home/domain/entities/movie_entity.dart';

abstract class HomeState {}
class HomeInitial extends HomeState{}

class HomeLoading extends HomeState{}

class HomeLoaded extends HomeState{
  final List <MovieEntity>  movies;
  final bool isOffline;

  HomeLoaded(this.movies, {this.isOffline = false});
}

class HomeError extends HomeState{
  final String message;

  HomeError(this.message);
}