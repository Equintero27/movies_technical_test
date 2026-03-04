import 'package:go_router/go_router.dart';

final router = new GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(path: '/home',
    builder: (context, state) => const HomeScreen(),
    ),
  ],
);