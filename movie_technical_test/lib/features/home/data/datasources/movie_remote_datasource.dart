import 'package:dio/dio.dart';

class MovieRemoteDatasource {
  final Dio dio;

  MovieRemoteDatasource(this.dio);
  Future<Response> getPopularMovies() async {
    return await dio.get('/movie/popular');
  }
}