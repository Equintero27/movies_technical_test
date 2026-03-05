import 'package:movie_technical_test/features/home/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity{
  MovieModel({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.overView,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel (
    id: json['id'], 
    title: json['title'],
    posterPath: json['posterPath'] ?? '',
    overView: json['overView'] ?? '',
    );
  }
}