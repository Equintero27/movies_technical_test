import 'package:movie_technical_test/core/network/connectivity_service.dart';
import 'package:movie_technical_test/features/home/domain/usescases/get_popular_movies_usescase.dart';
import 'package:movie_technical_test/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetPopularMoviesUsescase getPopularMovies;

  HomeCubit(this.getPopularMovies) : super(HomeInitial());

  Future<void> fetchMovies() async {
    emit(HomeLoading());

    try{
      final movies = await getPopularMovies();
      final isOffline = !(await ConnectivityService().hasInternet());

      emit(HomeLoaded(movies, isOffline: isOffline));
    }catch (e){
      emit(HomeError("Error al buscar películas"));
    }
  }
}