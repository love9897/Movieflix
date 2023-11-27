import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:netflix_copy/pages/bottom_navbar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          splash: Image.asset('images/moviesflix.png'),
          nextScreen: const BottomNav(),
          splashTransition: SplashTransition.scaleTransition,
          animationDuration: const Duration(seconds: 1),
          splashIconSize: 150,
          curve: Curves.fastEaseInToSlowEaseOut),
    );
  }
}
