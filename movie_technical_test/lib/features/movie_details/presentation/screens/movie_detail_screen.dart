import 'package:flutter/material.dart';
import 'package:movie_technical_test/features/home/domain/entities/movie_entity.dart';

class MovieDetailScreen extends StatelessWidget{
  final MovieEntity movie;

  const MovieDetailScreen({
    super.key, 
    required this.movie
    });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
            tag: movie.id, 
            child: Image.network(
              movie.posterPath.isNotEmpty ? 
                "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                : "https://via.placeholder.com/300x450",
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              )
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ///TITLE
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ///DETAILS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 6),
                          Text(movie.voteAverage.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 6),
                          Text(movie.releaseDate),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Descripción general",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    movie.overview,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}