import 'package:flutter/material.dart';
import 'package:netflix_copy/pages/bottom_navbar.dart';
import 'package:netflix_copy/pages/home.dart';
import 'package:netflix_copy/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moviesflix',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      initialRoute: 'splash',
      routes: {
        'splash': (_) => const SplashScreen(),
        'home': (context) => const HomeScreen(),
        'bottom': (context) => const BottomNav(),
      },
    );
  }
}
