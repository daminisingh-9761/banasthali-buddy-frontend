import 'package:flutter/material.dart';
import 'package:frontend/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banasthali Buddy',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFF9A826),
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D1B2A),
          elevation: 0,
          titleTextStyle:
          TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          color: const Color(0xFF1B263B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAlias,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Color(0xFFF9A826),
          titleTextStyle:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          subtitleTextStyle: TextStyle(color: Colors.white70),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white54,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF9A826),
            foregroundColor: const Color(0xFF0A1D37),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white70,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: const TextStyle(color: Colors.white12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white54),
          ),
          errorStyle: const TextStyle(color: Colors.orangeAccent),
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xFFF9A826),
          secondary: const Color(0xFFF9A826),
          background: const Color(0xFF0D1B2A),
          surface: const Color(0xFF1B263B), // card color
          onSurface: Colors.orange, // text color on card
        ),
      ),
      home: const SplashScreen(),
    );
  }
}