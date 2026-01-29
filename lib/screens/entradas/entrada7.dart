import 'package:flutter/material.dart';
import '../side_drawer.dart';


class Enlace7 extends StatelessWidget {
  const Enlace7({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Imagenes repetidas"),
      ),
      drawer: const SideDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	        children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	            children:[
                Image.asset('assets/images/Ricardo.png', width: 100, height: 100,),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	            children:[
                Image.network('https://static.wikia.nocookie.net/rdr/images/c/ca/Redharlow.png/revision/latest?cb=20111030203151&path-prefix=es', width: 100),
                Image.network('https://static.wikia.nocookie.net/rdr/images/c/ca/Redharlow.png/revision/latest?cb=20111030203151&path-prefix=es', width: 100)
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	            children:[
                Image.asset('assets/images/Ricarda.png', width: 100, height: 100,),
                Image.asset('assets/images/Ricarda.png', width: 100, height: 100,),
                Image.asset('assets/images/Ricarda.png', width: 100, height: 100,),
              ]
            ),
          ]
        ),
        )
      ),
    );
  }
}