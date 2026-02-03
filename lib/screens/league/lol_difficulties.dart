import 'package:flutter/material.dart';
import '../screens.dart';
import '../side_drawer.dart';
import 'package:google_fonts/google_fonts.dart';


class DifMenuLol extends StatelessWidget {
  const DifMenuLol({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Choose difficulty",
          style: GoogleFonts.kenia(
            letterSpacing: 2.0,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const SideDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/DifBackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                difBtn("EASY", "(Only name)", Colors.green, () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const EasyLol()));
                }),
                SizedBox(height: 50),
                difBtn("MEDIUM", "(Name, price and tier)", Colors.orange, () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const MediumLol()));
                }),
                SizedBox(height: 50),
                difBtn("HARD", "(Name, price, tier and exact statistics)", Colors.red, () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const HardLol()));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget difBtn(String title, String subtitle, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.kenia(
              color: Color.fromARGB(200, 0, 0, 0),
              letterSpacing: 5,
              fontSize: 50,
              fontWeight: FontWeight.bold,
              height: 1
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: GoogleFonts.balthazar(color: Color.fromARGB(175, 0, 0, 0), fontSize: 20, height: 0.75),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}