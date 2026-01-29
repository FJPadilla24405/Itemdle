import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import '../../themes/themes.dart';
import '../side_drawer.dart';
import '../screens.dart';

class Enlace12 extends StatefulWidget {
  const Enlace12({super.key});


  @override
  State<Enlace12> createState() => _RandomColors();
}

class _RandomColors extends State<Enlace12> {
  int points = 0;
  late String randomName;
  late Color randomColor;
  var colorNames = ['rojo', 'naranja', 'amarillo', 'verde', 'celeste', 'azul', 'morado', 'rosa', 'marron', 'negro', 'gris'];
  var colorHex = [
    const Color.fromARGB(255, 255, 0, 0),
    const Color.fromARGB(255, 255, 136, 0),
    const Color.fromARGB(255, 255, 238, 0),
    const Color.fromARGB(255, 9, 255, 0),
    const Color.fromARGB(255, 0, 217, 255),
    const Color.fromARGB(255, 0, 26, 255),
    const Color.fromARGB(255, 132, 0, 255),
    const Color.fromARGB(255, 255, 0, 242),
    const Color.fromARGB(255, 92, 41, 0),
    const Color.fromARGB(255, 0, 0, 0),
    const Color.fromARGB(255, 147, 147, 147),
  ];

  @override
  void initState() {
    super.initState();
    getRandomColor();
    getRandomName();
    timer();
  }

  void timer() {
    Timer.periodic(const Duration(milliseconds: 750), (timer) {
      getRandomColor();
      getRandomName();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Temas().Default(),
      home: Scaffold(
        appBar: AppBar(
            title: const Text("Juego de colores"),
          ),
          drawer: const SideDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Puntos: $points',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  onGiftTap(randomName, randomColor);
                },
                child: Column(
                  children: [
                    Container(width: 120, color: randomColor, height: 120),
                    Text(
                      randomName,
                      style: TextStyle(
                        color: randomColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void getRandomColor() {
    Random random = Random();
    int randomNumber = random.nextInt(colorHex.length);
    randomColor = colorHex[randomNumber];
  }


  void getRandomName() {
    Random random = Random();
    int randomNumber = random.nextInt(colorNames.length);
    randomName = colorNames[randomNumber];
  }


  String hexToStringConverter(Color hexColor) {
    String resultado = '';
    for (int i = 0; i < colorHex.length; i++) {
      if (hexColor == colorHex[i]) {
        resultado = colorNames[i];
      }
    }
    return resultado;
  }


  void onGiftTap(String name, Color color) {
    var colorToString = hexToStringConverter(color);
    if (name == colorToString) {
      points += colorHex.length;
    } else if (points > 0){
      points -= 5;
    }

    if (points < 0) {
      points = 0;
    }
    setState(() {});
  }
}
