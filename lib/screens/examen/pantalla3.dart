import 'package:flutter/material.dart';
import 'dart:math';

import '../../themes/themes.dart';
import '../home_screen.dart';
import 'pantalla1.dart';

class Pantalla3 extends StatefulWidget {
  const Pantalla3({super.key});

  @override
  State<Pantalla3> createState() => _AdivinaNumero();
}

class _AdivinaNumero extends State<Pantalla3> {
  int numTotal = 0;
  String texto = "Lanza los dados hasta llegar a 51";

  // Metodo para resetear en numero y ajustar el texto
  void reset() {
    numTotal = 0;
    texto = "Lanza los dados hasta llegar a 51";
    setState(() {});
  }

  // Metodo que suma al numero total un random entre 1 y 6 y ajusta el texto a lo que ocurra
  void sumaNumero() {
    Random random = Random();
    int randomNumber = random.nextInt(6);
    numTotal += 1+randomNumber;
    if (numTotal > 51) {
      texto = "Te has pasado. Resetea para volver a intentarlo";
    } else if (numTotal == 51) {
      texto = "Felicidades. Has ganado el juego";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Temas().Default(),
      home: Scaffold(
        appBar: AppBar(
            title: const Text("Pantalla 3"),
          ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Texto con el numero al que le estamos sumando
              Text(
                'Puntos: $numTotal',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              // Texto dinámico que depende de si estamos sumando hasta 51, hemos conseguido 51 o nos hemos pasado
              Text(
                texto,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Boton para resetear
                    ElevatedButton(
                      onPressed: () {
                        reset();
                      },
                    child: const Text('Resetear'),
                    ),
                    // Boton para sumar
                    ElevatedButton(
                      onPressed: () {
                        sumaNumero();
                      },
                    child: const Text('Lanzar dados'),
                    ),
                  ],
              ),
              // Boton para ir a la primera pantalla
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Pantalla1()));
                },
              child: const Text('Ir a la primera pantalla'),
              ),
            ],
          ),
        )
      )
    );
  }

}