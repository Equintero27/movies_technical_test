import 'package:movie_technical_test/features/home/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity{
  MovieModel({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.overview,
    required super.releaseDate,
    required super.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel (
    id: json['id'] ?? 0, 
    title: json['title'] ?? '',
    posterPath: json['poster_path'] ?? '',
    overview: json['overview'] ?? '',
    releaseDate: json['release_date'] ?? '',
    voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}