import 'package:flutter/material.dart';
import '../side_drawer.dart';
import 'package:google_fonts/google_fonts.dart';


class DifMenuLol extends StatelessWidget {
  const DifMenuLol({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Choose difficulty",
          style: GoogleFonts.kenia(
            letterSpacing: 2.0,
            fontSize: 30,
            fontWeight: FontWeight.bold
          )
        ),
      ),
      drawer: const SideDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
	          children:[
              Image.asset('assets/images/RedHarlow.jpg', width: 300, height: 300,),
              Text("Francisco Javier Padilla López",
                style: GoogleFonts.kenia(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ), textAlign: TextAlign.center),
            ]
          )
        )
      ),
    );
  }
}