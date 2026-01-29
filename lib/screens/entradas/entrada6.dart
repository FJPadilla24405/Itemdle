import 'package:flutter/material.dart';
import '../side_drawer.dart';
import 'package:google_fonts/google_fonts.dart';


class Enlace6 extends StatelessWidget {
  const Enlace6({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filas de texto"),
      ),
      drawer: const SideDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	        children:[
                Text("Hola que tal soy colosal como este pedazo de texto que no cabe",
                softWrap: false,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ), textAlign: TextAlign.center,),
           
                Text("Absolutamente insano que este pasando esto de una manera tan absurda",
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ), textAlign: TextAlign.center,),
        
                Text("El catalán me acaba de llamar para trabajar, dice que tiene una empresa montada",
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.kenia(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ), textAlign: TextAlign.center,),
          ]
        ),
        )
      ),
    );
  }
}