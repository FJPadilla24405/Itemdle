import 'package:flutter/material.dart';
import '../screens.dart';
import '../side_drawer.dart';

import '../../themes/themes.dart';

class Enlace15 extends StatelessWidget {
  const Enlace15({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulario',
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
  final List<TextEditingController> _textEditingControllers = [];
  List<Widget> _widgets = [];

  bool tieneMascota = false;

  // ✔ Estados visuales de los checkbox
  bool perro = false;
  bool gato = false;
  bool pajaro = false;

  bool leer = false;
  bool videojuegos = false;
  bool dibujar = false;

  FormWidget() {
    _generarCamposBase();
  }

  void _generarCamposBase() {
    List<List> fieldNames = [
      ["Nombre", TextInputType.name],
      ["Número de teléfono", TextInputType.phone],
      ["Fecha de nacimiento", TextInputType.datetime],
      ["Email", TextInputType.emailAddress],
      ["Dirección", TextInputType.streetAddress],
      ["Contraseña", TextInputType.visiblePassword],
      ["Descripción", TextInputType.multiline]
    ];

    _widgets = [];
    _textEditingControllers.clear();

    for (int i = 0; i < fieldNames.length; i++) {
      String fieldName = fieldNames[i][0];
      TextInputType textType = fieldNames[i][1];

      TextEditingController controller = TextEditingController();
      _textEditingControllers.add(controller);

      _widgets.add(
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: _createTextFormField(fieldName, controller, textType),
        ),
      );
    }
  }

  
  TextFormField _createTextFormField(
      String fieldName, TextEditingController controller, TextInputType textType) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      keyboardType: textType,
      obscureText: fieldName == "Contraseña",
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor, introduzca $fieldName.';
        }
        return null;
      },
      decoration: InputDecoration(
        icon: const Icon(Icons.person),
        hintText: fieldName,
        labelText: 'Introduzca $fieldName',
      ),
      controller: controller,
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("Formulario")),
    drawer: const SideDrawer(),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            ..._widgets, // los campos base
            SwitchListTile(
              title: const Text("¿Tienes mascota?"),
              value: tieneMascota,
              onChanged: (v) {
                setState(() {
                  tieneMascota = v;
                });
              },
            ),
            // ✅ Campos dinámicos
            if (tieneMascota) ...[
              const Text("¿Qué mascota tienes?",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CheckboxListTile(
                title: const Text("Perro"),
                value: perro,
                onChanged: (v) => setState(() => perro = v!),
              ),
              CheckboxListTile(
                title: const Text("Gato"),
                value: gato,
                onChanged: (v) => setState(() => gato = v!),
              ),
              CheckboxListTile(
                title: const Text("Pájaro"),
                value: pajaro,
                onChanged: (v) => setState(() => pajaro = v!),
              ),
            ] else ...[
              const Text("Preferencias en casa",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CheckboxListTile(
                title: const Text("Leer"),
                value: leer,
                onChanged: (v) => setState(() => leer = v!),
              ),
              CheckboxListTile(
                title: const Text("Videojuegos"),
                value: videojuegos,
                onChanged: (v) => setState(() => videojuegos = v!),
              ),
              CheckboxListTile(
                title: const Text("Dibujar"),
                value: dibujar,
                onChanged: (v) => setState(() => dibujar = v!),
              ),
            ],
            ElevatedButton(
              onPressed: () {
                _formKey.currentState?.validate();
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    ),
  );
}
}