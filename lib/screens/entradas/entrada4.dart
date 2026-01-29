import 'package:flutter/material.dart';
import '../side_drawer.dart';


class Enlace4 extends StatelessWidget {
  const Enlace4({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filas de iconos"),
      ),
      drawer: const SideDrawer(),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	        children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	            children:[
                Icon(Icons.airline_seat_flat_outlined, size: 100),
                Icon(Icons.agriculture, size: 100),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	            children:[
                Icon(Icons.phone_in_talk_rounded, size: 100),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	            children:[
                Icon(Icons.restore_from_trash, size: 100),
                Icon(Icons.view_comfortable_rounded, size: 100),
              ]
            ),
          ]
        ),
        )
        
      ),
    );
  }
}