import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:movie_technical_test/core/network/connectivity_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_model.dart';

class MovieRemoteDatasource {
  final Dio dio;
  final ConnectivityService connectivity;

  MovieRemoteDatasource(
    this.dio,
    this.connectivity,
    );

    static const String cacheKey = "cached_movies";

  Future<List<MovieModel>> getPopularMovies() async {

    final prefs = await SharedPreferences.getInstance();
    final hasInternet = await connectivity.hasInternet();

    // SI HAY INTERNET
    if(hasInternet){
      final response = await dio.get('/movie/popular');
      final results = response.data['results'] as List;

    //GUARDAR EN CACHE
    await prefs.setString(cacheKey, jsonEncode(results));

    return results.map((movie) => MovieModel.fromJson(movie)).toList();
    }

       // SI NO HAY INTERNET usar cache
    final cachedData = prefs.getString(cacheKey);

    if(cachedData != null){
      final List decoded = jsonDecode(cachedData);

      return decoded.map((movie) => MovieModel.fromJson(movie)).toList();
    }

    // SIN CONEXIÓN Y SIN DATOS EN CACHE
    throw Exception("Sin conexión y sin datos guardados");
  }
}
