import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/themes.dart';
import '../home_screen.dart';
import '../side_drawer.dart';
import 'pantalla2.dart';

class Pantalla1 extends StatefulWidget {
  const Pantalla1({super.key});

  @override
  State<Pantalla1> createState() => Pantalla1State();
}

class Pantalla1State extends State<Pantalla1> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pantalla 1',
      // Si es oscuro tema oscuro si no tema claro
      theme: Temas().Default(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Fco Javier 2ºDAM",
            style: GoogleFonts.pacifico(
              letterSpacing: 8.0,
              fontSize: 20,
            ),
          ),
          
        ),
        drawer: const SideDrawer(),
        body: Center(
          child: SingleChildScrollView (
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Francisco Javier Padilla López',
                  style: GoogleFonts.kenia(
                    fontSize: 38,
                    fontWeight: FontWeight.bold
                  ), textAlign: TextAlign.center,
                ),
                Image.asset('assets/images/Pollo.jpg', width: 300, height: 300,),
                // Boton para ir a la siguiente pantalla
                ElevatedButton(onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Pantalla2()
                  ));
                }, child: const Text("Ir a la segunda pantalla")),
              ]
            )
          ),
        )
      )
    );
  }
}