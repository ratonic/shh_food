import 'package:flutter/material.dart';
import 'package:shh_food/views/splash_screen.dart';
import 'package:shh_food/views/welcome_screen.dart'; // Importa WelcomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '¡Shh! Food',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4B0082)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Inicialmente mostramos el SplashScreen
    );
  }
}