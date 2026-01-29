import 'package:flutter/material.dart';
import '../side_drawer.dart';


class Enlace5 extends StatelessWidget {
  const Enlace5({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Columnas de Ricardos"),
      ),
      drawer: const SideDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	        children:[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	            children:[
                Image.asset('assets/images/Ricardo.png', width: 150, height: 150,),
                Image.asset('assets/images/Ricarda.png', width: 150, height: 150,),
                Image.asset('assets/images/RicardoFiestas.png', width: 150, height: 150,),
              ]
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	            children:[
                Image.asset('assets/images/RicardoElegante.png', width: 150, height: 150,),
                Image.asset('assets/images/RicardoNavidad.png', width: 150, height: 150,),
              ]
            ),
          ]
        ),
        )
        
      ),
    );
  }
}