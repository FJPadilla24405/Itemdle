import 'package:flutter/material.dart';
import '../side_drawer.dart';


class Enlace8 extends StatelessWidget {
  const Enlace8({super.key});


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ricardos responsive"),
      ),
      drawer: const SideDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: width*0.9,
            height: height*0.8,
            color: Colors.orangeAccent,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	          children:[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	              children:[
                  Image.asset('assets/images/RicardoFiestas.png', width: width*0.1, height: width*0.1,),
                  Text("Ricardo Fiestas",
                  style: TextStyle(
                    fontSize: width*0.01,
                    color: Colors.black
                  ), textAlign: TextAlign.center,),
                ]
              ),
            ]
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	          children:[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	              children:[
                  Image.asset('assets/images/Ricardo.png', width: height*0.1, height: height*0.1,),
                  Text("Ricardo",
                  style: TextStyle(
                    fontSize: height*0.01,
                    color: Colors.black
                  ), textAlign: TextAlign.center,),
                ]
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	              children:[
                  Image.asset('assets/images/Ricarda.png', width: height*0.1, height: height*0.1,),
                  Text("Ricarda",
                  style: TextStyle(
                    fontSize: height*0.01,
                    color: Colors.black
                  ), textAlign: TextAlign.center,),
                ]
              ),
            ]
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	          children:[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	              children:[
                  Image.asset('assets/images/RicardoElegante.png', width: width*0.15, height: width*0.15,),
                  Text("Ricardo Presidente",
                  style: TextStyle(
                    fontSize: width*0.015,
                    color: Colors.black
                  ), textAlign: TextAlign.center,),
                ]
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	              children:[
                  Image.asset('assets/images/RicardoNavidad.png', width: height*0.15, height: height*0.15,),
                  Text("Ricardo Navidad",
                  style: TextStyle(
                    fontSize: height*0.015,
                    color: Colors.black
                  ), textAlign: TextAlign.center,),
                ]
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	              children:[
                  Image.asset('assets/images/RicardoPelo.png', width: width*0.15, height: width*0.15,),
                  Text("Ricardo Pelo",
                  style: TextStyle(
                    fontSize: width*0.015,
                    color: Colors.black
                  ), textAlign: TextAlign.center,),
                ]
              ),
            ]
          ),
            ]
          )
          )
        )
      ),
    );
  }
}