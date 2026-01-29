import 'package:flutter/material.dart';

import '../side_drawer.dart';
import '../../themes/themes.dart';
import '../screens.dart';

class Enlace10 extends StatelessWidget {
  const Enlace10({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de clicks',
      theme: Temas().Default(),
      home: const MiContador()
    );
  }
}

class MiContador extends StatefulWidget {
  const MiContador({super.key});

  @override
  State<MiContador> createState() => _MiContadorState();
}

class _MiContadorState extends State<MiContador> {
  int _numeroVeces = 0;

  _incrementar() {
    setState(() {
      _numeroVeces++;
    });
    
  }
  _decrementar() {
    setState(() {
      if (_numeroVeces>0) {
        _numeroVeces--;
      }
    });
    
  }
  _resetear() {
    setState(() {
      _numeroVeces = 0;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
          AppBar(title: const Text("Contador de clicks"),),
      drawer: const SideDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
            "Has pulsado $_numeroVeces veces",
            style: const TextStyle(fontSize:30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _decrementar, child: const Text("Decrementar")),
                ElevatedButton(onPressed: _resetear, child: const Text("Resetear")),
                ElevatedButton(onPressed: _incrementar, child: const Text("Incrementar"))
              ],
            )
          ],
        ),
        ),
      );
  }
}