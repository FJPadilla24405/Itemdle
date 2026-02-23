// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

// Temas para la aplicación
class Themes extends StatelessWidget {
  const Themes({super.key});

  // Tema por defecto
  ThemeData Default() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.cyanAccent,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
      listTileTheme: const ListTileThemeData(textColor: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 53, 53, 53),
          foregroundColor: Colors.cyan,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.cyanAccent),
      ),
      iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 255, 242)),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.cyan,
        ),
        bodyMedium: TextStyle(fontSize: 18, color: Colors.cyanAccent),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 53, 53, 53),
        foregroundColor: Colors.cyan,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
        labelStyle: TextStyle(color: Colors.grey),
        iconColor: Colors.cyan,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll<Color>(Colors.cyan),
        trackColor: WidgetStateProperty<Color?>.fromMap(
          <WidgetStatesConstraint, Color>{WidgetState.selected: Colors.black},
        ),
      ),
    );
  }

  // Tema para las pantallas de juego
  ThemeData Game() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.cyanAccent,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
      listTileTheme: const ListTileThemeData(textColor: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 53, 53, 53),
          foregroundColor: Colors.cyan,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.cyanAccent),
      ),
      iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 255, 242)),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.cyan,
        ),
        bodyMedium: TextStyle(fontSize: 18, color: Colors.cyanAccent),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 53, 53, 53),
        foregroundColor: Colors.cyan,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
        labelStyle: TextStyle(color: Colors.grey),
        iconColor: Colors.cyan,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll<Color>(Colors.cyan),
        trackColor: WidgetStateProperty<Color?>.fromMap(
          <WidgetStatesConstraint, Color>{WidgetState.selected: Colors.black},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
