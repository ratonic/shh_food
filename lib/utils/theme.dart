import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF4B0082), // Morado oscuro
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF4B0082),
  ).copyWith(
    secondary: const Color(0xFF40E0D0), // Verde turquesa
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.light().textTheme.copyWith(
      bodyLarge: const TextStyle(color: Colors.white),
      bodyMedium: const TextStyle(color: Colors.white),
      displayLarge: const TextStyle(color: Colors.white),
      displayMedium: const TextStyle(color: Colors.white),
      titleLarge: const TextStyle(color: Colors.white),
      titleMedium: const TextStyle(color: Colors.white),
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
);
