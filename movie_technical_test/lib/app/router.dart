import 'package:go_router/go_router.dart';
import 'package:movie_technical_test/features/home/domain/entities/movie_entity.dart';
import 'package:movie_technical_test/features/movie_details/presentation/screens/movie_detail_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';

final router = new GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/movie',
      builder: (context, state){
        final movie = state.extra as MovieEntity;
        return MovieDetailScreen(movie: movie,
        );
      },
    ),
  ],
);