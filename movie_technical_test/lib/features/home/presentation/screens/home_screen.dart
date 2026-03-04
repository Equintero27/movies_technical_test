import 'package:flutter/material.dart';
import 'package:movie_technical_test/core/network/dio_client.dart';

import '../../../../core/network/dio_client.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result = "Cargando. . .";

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }
  void fetchMovies() async {
    try{
      final dio = DioClient().dio;
      final response = await dio.get('/movie/popular');

      setState(() {
        result = "Peliculas recibidas: ${response.data['results'].length}";
      });
      print(response.data);

    }catch (e){
     setState(() {
      result = "Error: $e";
     });
     print("ERROR: $e");
    }
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(child: Text(result)),
    );
  }
}