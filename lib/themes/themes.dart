// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Temas extends StatelessWidget {
  const Temas({super.key});

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
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.black,
      ),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 53, 53, 53),
          foregroundColor: Colors.cyan,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.cyanAccent,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 0, 255, 242),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan),
        bodyMedium: TextStyle(fontSize: 18, color: Colors.cyanAccent),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 53, 53, 53),
        foregroundColor: Colors.cyan,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        iconColor: Colors.cyan
      ),
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll<Color>(Colors.cyan),
        trackColor: WidgetStateProperty<Color?>.fromMap(<WidgetStatesConstraint, Color>{WidgetState.selected: Colors.black},)
      )
    );
  }

  ThemeData League() {
    return ThemeData(
      brightness: Brightness.light,
        primaryColor: const Color.fromARGB(255, 120, 100, 0),
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 23, 53),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 100, 80, 0),
          foregroundColor: Color.fromARGB(255, 0, 23, 53),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 23, 53),),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color.fromARGB(255, 100, 80, 0),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 100, 80, 0),
            foregroundColor: Color.fromARGB(255, 0, 23, 53),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 120, 100, 0),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 120, 100, 0),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 148, 118, 0)),
          bodyMedium: TextStyle(fontSize: 18, color: Color.fromARGB(255, 182, 145, 0)),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 0, 23, 53),
          foregroundColor: Color.fromARGB(255, 100, 80, 0),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 100, 80, 0)),
          ),
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 0, 23, 53),
          ),
          iconColor: Color.fromARGB(255, 100, 80, 0)
        ),
        switchTheme: SwitchThemeData(
          thumbColor: const WidgetStatePropertyAll<Color>(Color.fromARGB(255, 100, 80, 0)),
          trackOutlineColor: const WidgetStatePropertyAll<Color>(Color.fromARGB(255, 100, 80, 0)),
          trackColor: const WidgetStatePropertyAll<Color>(Color.fromARGB(255, 0, 23, 53))
        )
      );
  }
  
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}