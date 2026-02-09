import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'side_drawer.dart';
import '../themes/themes.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeScreen',
      theme: Themes().Default(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Itemdle",
            style: GoogleFonts.kenia(
              letterSpacing: 8.0,
              fontSize: 50,
              fontWeight: FontWeight.bold
            ), textAlign: TextAlign.center,
          ),
        ),
        drawer: const SideDrawer(),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/HomeBackground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: 20,
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.5,
                    alignment: Alignment(0, 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      border: Border.all(
                        width: 10,
                        color: Color.fromRGBO(255, 255, 255, 0.15)
                      ), borderRadius: BorderRadius.circular(50),
                    ),
                    child: 
                      Text("Welcome to Itemdle! A game to test your knowledge on various items from videogames. So far the only option available for videogames is League Of Legends.",
                        style: GoogleFonts.balthazar(
                          fontSize: 19,
                        ), softWrap: true,
                        textAlign: TextAlign.center,
                      )
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.5,
                    alignment: Alignment(0, 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      border: Border.all(
                        width: 10,
                        color: Color.fromRGBO(255, 255, 255, 0.15)
                      ), borderRadius: BorderRadius.circular(50),
                    ),
                    child: 
                      Text("The goal is to accurately guess the details from every item based on their icon. Each videogame category will have up to three difficulties, from easy to hard. The harder the difficulty is the more fields you'll have to fill out.",
                        style: GoogleFonts.balthazar(
                        fontSize: 19,
                        ), softWrap: true,
                        textAlign: TextAlign.center,)
                    ),
                  Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.5,
                    alignment: Alignment(0, 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      border: Border.all(
                        width: 10,
                        color: Color.fromRGBO(255, 255, 255, 0.15)
                      ), borderRadius: BorderRadius.circular(50),
                    ),
                    child: 
                      Text("Start by pressing the three lines icon on the top left and choosing the videogame category. Have fun!",
                        style: GoogleFonts.balthazar(
                          fontSize: 19,
                        ), softWrap: true,
                      textAlign: TextAlign.center,)
                  ),
                ]
              )
            ),
          )
        )
      )
    );
  }
}