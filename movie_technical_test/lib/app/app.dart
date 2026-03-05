import 'package:flutter/material.dart';
import 'package:movie_technical_test/features/home/presentation/screens/home_screen.dart';
import 'router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

static _MyAppState? of(BuildContext context){
  return context.findAncestorStateOfType<_MyAppState>();
}

@override
State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void changeTheme(ThemeMode mode){
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      routerConfig : router,
    );
  }
}