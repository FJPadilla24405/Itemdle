import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../tools/variabletimer.dart';
import '../screens.dart';
import '../side_drawer.dart';
import 'dart:math';

import '../../themes/themes.dart';

class Enlace13 extends StatefulWidget {
  const Enlace13({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _RandomImages createState() => _RandomImages();
}

class _RandomImages extends State<Enlace13> {
  int points = 0;
  bool click = false;
  late String randomImage;
  late double randomWidth;
  late double randomHeight;
  late Image image;
  var assetsImages = [
    'assets/images/Ricardo.png',
    'assets/images/Ricarda.png',
    'assets/images/RicardoFiestas.png',
    'assets/images/RicardoElegante.png',
    'assets/images/RicardoNavidad.png',
    'assets/images/RicardoPelo.png'
  ];
  late double screenWidth = 500;
  late double screenHeight = 1000;

  @override
  void initState() {
    super.initState();
    _loadPoints();
    getRandomImage();
    getRandomPosition();
    extractPoints();
    timer();
  }

  void timer() {
    VariableTimer(const Duration(milliseconds: 1500), (timer) {
    getRandomImage();
    getRandomPosition();
    extractPoints();
    setState(() {});
    
    timer.period = Duration(milliseconds: 1500-points*2);
      
  });
  }

  _loadPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedPoints = prefs.getInt('points') ?? 0;

    setState(() {
      points = savedPoints;
    });
  }

  _incrementPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedPoints = prefs.getInt('points') ?? points;
    savedPoints = savedPoints + 5;

    await prefs.setInt('points', savedPoints);

    setState(() {
      points = savedPoints;
    });
  }

  _decrementPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedPoints = prefs.getInt('points') ?? points;
    savedPoints = savedPoints - (savedPoints * 0.25).round();
    if (savedPoints < 0) savedPoints = 0;

    await prefs.setInt('points', savedPoints);

    setState(() {
      points = savedPoints;
    });
  }


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Temas().Default(),
      home: Scaffold(
         appBar: AppBar(
            title: const Text("Juego de imágenes"),
          ),
          drawer: const SideDrawer(),
        body: Stack(
          children: [
            
            Positioned(
            left: randomWidth,
            bottom: randomHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Puntos: $points',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Center(
              child: GestureDetector(
                
                onTap: () {
                  onGiftTap(image);
                },
                child: Column(
                  children: [
                    
                    image = Image.asset(randomImage, width: 150, height: 150,),
                    
                  ],
                ),
              ),
            ),]
                ),
            
             
      )
    
  ]
)
        
      ),
    );
  }


  void getRandomImage() {
    
    Random random = Random();
    int randomNumber = random.nextInt(6);
    randomImage = assetsImages[randomNumber];
  }

  void getRandomPosition() {
    Random random = Random();
    randomWidth = random.nextDouble() * (screenWidth - 150);
    randomHeight = random.nextDouble() * (screenHeight - 275);
  }

  void extractPoints() {
    if (points > 0 && !click) {
      _decrementPoints();
    }
    click = false;
  }

  void onGiftTap(Image image) {
      if (!click) {
        _incrementPoints();
        click = true;
      }
    setState(() {});
  }
}