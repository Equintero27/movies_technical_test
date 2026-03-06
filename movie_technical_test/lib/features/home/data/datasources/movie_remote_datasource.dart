import 'package:dio/dio.dart';
import 'package:movie_technical_test/core/network/connectivity_service.dart';
import '../models/movie_model.dart';

class MovieRemoteDatasource {
  final Dio dio;
  final ConnectivityService connectivity;

  MovieRemoteDatasource(
    this.dio,
    this.connectivity,
    );

  Future<List<MovieModel>> getPopularMovies() async {
    final hasInternet = await connectivity.hasInternet();
    if(!hasInternet){
      throw Exception("Verifica tu conexión a internet");
    }
    final response = await dio.get('/movie/popular');
    final results = response.data['results'] as List;
    
    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}