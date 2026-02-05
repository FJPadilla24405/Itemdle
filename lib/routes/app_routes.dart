import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRoutes {
  // Definir nombres para las rutas
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';

  // Mapa de rutas
  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomeApp(),
    login: (context) => const LoginScreen(),
  };
}