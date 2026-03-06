import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_technical_test/core/network/connectivity_service.dart';
import 'package:movie_technical_test/core/network/dio_client.dart';
import 'package:movie_technical_test/features/home/data/datasources/movie_remote_datasource.dart';
import 'package:movie_technical_test/features/home/data/repositories/movie_repository_impl.dart';
import 'package:movie_technical_test/features/home/domain/usescases/get_popular_movies_usescase.dart';
import 'package:movie_technical_test/features/home/presentation/cubit/home_cubit.dart';
import 'package:movie_technical_test/features/home/presentation/cubit/home_state.dart';
import 'package:movie_technical_test/features/profile/presentation/screens/profile_screen.dart';


class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    final dio = DioClient().dio;
    final connectivity = ConnectivityService();
    final remoteDataSource = MovieRemoteDatasource(dio, connectivity);
    final repository = MovieRepositoryImpl(remoteDataSource);
    final useCase = GetPopularMoviesUsescase(repository);

    return BlocProvider(create: (_) => HomeCubit(useCase)..fetchMovies(),
    child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}
  class _HomeViewState extends State<HomeView> {
    bool isOffline = false;

    @override
    void initState(){
      super.initState();
      checkInitialConnection();
      listenConnectivity();
    }

    void checkInitialConnection() async {
      final result = await Connectivity().checkConnectivity();

      final hasConnection = 
      result.contains(ConnectivityResult.mobile)||
      result.contains(ConnectivityResult.wifi);

      setState(() {
        isOffline = !hasConnection;
      });
    }

  void listenConnectivity() {
  Connectivity().onConnectivityChanged.listen((results) {

    final hasConnection = results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi);

    setState(() {
      isOffline = !hasConnection;
    });
  });
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text ("Peliculas populares"),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProfileScreen(),
          ),
        );
      },
    ),
  ],
),
      body: Column(
        children: [
          if(isOffline)
          Container(
            width: double.infinity,
            color: Colors.red,
            padding: const EdgeInsets.all(8),
            child: const Text("Modo offline - mostrando datos guardados", 
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
      ),
      
      Expanded(
        child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading){
            return const Center(
              child: CircularProgressIndicator(),
              );
          }

          if (state is HomeError){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Icon(Icons.wifi_off_rounded, size: 40),
                    SizedBox(height: 20),
                    Text("Verifique su conexión a internet e intente nuevamente"),
                    ElevatedButton(
                        onPressed: (){
                          context.read<HomeCubit>().fetchMovies();
                        },
                        child: const Text("Reintentar"),
                    ),
                ],
              ),
            );
          }

          if (state is HomeLoaded){
            return RefreshIndicator(
              onRefresh: () async{
                context.read<HomeCubit>().fetchMovies();
              },
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    itemCount: state.movies.length,
                    itemBuilder: (context, index){
                      final movie = state.movies[index];

                        return GestureDetector(
                          onTap: () {
                            context.push('/movie', extra: movie);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                            child: Hero(
                              tag: movie.id,
                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                movie.posterPath.isNotEmpty ? 
                                "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                                : "https://via.placeholder.com/300x450",
                                fit: BoxFit.cover,
                              ),
                            ),
                            ),
                          ),
                          );
                      },
                    ),
                    ),
          );
        }
                  return const SizedBox();
                },
              ),
            ),
        ],
      ),
    );
  }
}