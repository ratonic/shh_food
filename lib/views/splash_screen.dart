import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shh_food/main.dart'; // Importante para el Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    // Simulamos carga de Appwrite o cualquier otra inicialización
    Timer(const Duration(seconds: 3), () {
      // Después de 3 segundos navegamos a Login (por ahora HomePage)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: '¡Shh! Food')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B0082), // Morado oscuro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Shh! Food',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: Color(0xFF40E0D0), // Verde turquesa
            ),
          ],
        ),
      ),
    );
  }
}
