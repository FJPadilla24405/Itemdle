import 'package:flutter/material.dart';

import '../../themes/themes.dart';
import '../home_screen.dart';
import 'pantalla3.dart';

class Pantalla2 extends StatelessWidget {
  const Pantalla2({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pantalla 2',
      theme: Temas().Default(),
      home: Formularios(),
    );
  }
}

class Formularios extends StatefulWidget {
  const Formularios({super.key});

  @override
  State<Formularios> createState() => FormWidget();
}

class FormWidget extends State<Formularios> {
  final _formKey = GlobalKey<FormState>();

  // Boolean con el que sabremos que version mostrar si intel o ryzen
  bool gustaIntel = false;

  // Estados visuales de los checkbox
  bool i3 = false;
  bool i5 = false;
  bool i7 = false;
  bool i9 = false;

  bool ryzen3 = false;
  bool ryzen5 = false;
  bool ryzen7 = false;
  bool ryzen9 = false;

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("Pantalla 2")),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            // Switch para escoger intel o amd
            SwitchListTile(
              title: const Text("Izq AMD | Dcha Intel"),
              value: gustaIntel,
              onChanged: (v) {
                setState(() {
                  gustaIntel = v;
                });
              },
            ),
            // Campos dinámicos
            if (gustaIntel) ...[
              const Text("¿Qué procesador intel prefieres?",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CheckboxListTile(
                title: const Text("Intel i3"),
                value: i3,
                onChanged: (v) => setState(() => i3 = v!),
              ),
              CheckboxListTile(
                title: const Text("Intel i5"),
                value: i5,
                onChanged: (v) => setState(() => i5 = v!),
              ),
              CheckboxListTile(
                title: const Text("Intel i7"),
                value: i7,
                onChanged: (v) => setState(() => i7 = v!),
              ),
              CheckboxListTile(
                title: const Text("Intel i9"),
                value: i9,
                onChanged: (v) => setState(() => i9 = v!),
              ),
            ] else ...[
              const Text("¿Qué procesador AMD prefieres?",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CheckboxListTile(
                title: const Text("Ryzen 3"),
                value: ryzen3,
                onChanged: (v) => setState(() => ryzen3 = v!),
              ),
              CheckboxListTile(
                title: const Text("Ryzen 5"),
                value: ryzen5,
                onChanged: (v) => setState(() => ryzen5 = v!),
              ),
              CheckboxListTile(
                title: const Text("Ryzen 7"),
                value: ryzen7,
                onChanged: (v) => setState(() => ryzen7 = v!),
              ),
              CheckboxListTile(
                title: const Text("Ryzen 9"),
                value: ryzen9,
                onChanged: (v) => setState(() => ryzen9 = v!),
              ),
            ],
            // Boton para guardar lo que escogemos
            ElevatedButton(
              onPressed: () {
                _formKey.currentState?.validate();
              },
              child: const Text('Guardar'),
            ),
            // Boton para pasar a la siguiente pantalla
            ElevatedButton(
              onPressed: () {
               Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Pantalla3()));
              },
              child: const Text('Ir a la tercera pantalla'),
            ),
          ],
        ),
      ),
    ),
  );
}
}