import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_technical_test/core/network/dio_client.dart';
import 'package:movie_technical_test/features/home/data/datasources/movie_remote_datasource.dart';
import 'package:movie_technical_test/features/home/data/repositories/movie_repository_impl.dart';
import 'package:movie_technical_test/features/home/domain/usescases/get_popular_movies_usescase.dart';
import 'package:movie_technical_test/features/home/presentation/cubit/home_cubit.dart';
import 'package:movie_technical_test/features/home/presentation/cubit/home_state.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    final dio = DioClient().dio;
    final remoteDataSource = MovieRemoteDatasource(dio);
    final repository = MovieRepositoryImpl(remoteDataSource);
    final useCase = GetPopularMoviesUsescase(repository);

    return BlocProvider(create: (_) => HomeCubit(useCase)..fetchMovies(),
    child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text ("Home")),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state){
          if(state is HomeLoading){
            return const Center(child: CircularProgressIndicator());
          }

          if(state is HomeError){
            return Center(child: Text(state.message));
          }
          if(state is HomeLoaded){
          return Center(child: Text("Peliculas: ${state.movies.length}"),
          );
        }
        return const SizedBox();
        },
        ),
      );
  }
}