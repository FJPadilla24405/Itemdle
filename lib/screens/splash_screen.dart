import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 10), () {
      // Verificar si el widget sigue montado antes de navegar
      // Para navegar, el widget debe de seguir en el árbol
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 2).animate(_controller)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _animation,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/SplashBackground.jpg"),
              fit: BoxFit.cover,
              ),
          ), 
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        'Itemdle',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.cyan,
                        ), textAlign: TextAlign.center,
                      ),
                      // Solid text as fill.
                      Text(
                        'Itemdle',
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Image.asset('assets/images/ItemSquareWorld_Atlas.png', width: 250, height: 250,),
                  Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        'Developed by: Fco Padilla',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.cyan,
                        ), textAlign: TextAlign.center,
                      ),
                      // Solid text as fill.
                      Text(
                        'Developed by: Fco Padilla',
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              )
            )
          )
        ),
      )
    );
  }
}