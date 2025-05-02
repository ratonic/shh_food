import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Importamos la pantalla splash

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '¡Shh! Food', // Nombre de la app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4B0082)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // Quitamos la banderita de debug
      home: const SplashScreen(), // Aquí arrancamos en el SplashScreen
    );
  }
}
class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Bienvenido a ¡Shh! Food',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
