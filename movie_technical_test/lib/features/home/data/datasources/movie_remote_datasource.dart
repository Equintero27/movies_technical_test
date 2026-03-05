import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class MovieRemoteDatasource {
  final Dio dio;

  MovieRemoteDatasource(this.dio);

  Future<List<MovieModel>> getPopularMovies() async {
    final response = await dio.get('/movie/popular');

    final results = response.data['results'] as List;

    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}