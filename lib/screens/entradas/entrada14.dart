import 'package:flutter/material.dart';
import '../screens.dart';
import '../side_drawer.dart';
import 'dart:math';

import '../../themes/themes.dart';

int getRandomNumber() {
    
    Random random = Random();
    int randomNumber = random.nextInt(100);
    return randomNumber;
}

int numRandom = getRandomNumber();
int numIntentos = 10;

class Enlace14 extends StatelessWidget {
  const Enlace14({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adivina el número',
      theme: Temas().Default(),
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _textEditingControllers = [];
  final List<Widget> _widgets = [];
  HomeWidget({super.key}) {
    _widgets.add(Text("Adivina un número aleatorio", textAlign: TextAlign.center));
    List<List> fieldNames = [
      ["un número para adivinar...", TextInputType.number],
    ];
    for (int i = 0; i < fieldNames.length; i++) {
      String fieldName = fieldNames[i][0];
      TextEditingController textEditingController =
          TextEditingController(text: "");
      TextInputType textType = fieldNames[i][1];
      _textEditingControllers.add(textEditingController);
      _widgets.add(Padding(
        padding: const EdgeInsets.all(7.0),
        child: _createTextFormField(fieldName, textEditingController, textType),
      ));
    }
    _widgets.add(ElevatedButton(
      onPressed: () {
        _formKey.currentState?.validate();
      },
      child: const Text('Adivinar'),
    ));
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
          } else if (numIntentos > 0) {
            if (int.parse(value) > numRandom) {
              numIntentos--;
              return 'El número que hay que adivinar es menor.\n($numIntentos intentos restantes)';
            } else if (int.parse(value) < numRandom) {
              numIntentos--;
              return 'El número que hay que adivinar es mayor.\n($numIntentos intentos restantes)';
            } else {
              _widgets.add(Text("FELICIDADES, has acertado el número $numRandom.\nToma un Ricardo como premio :)", textAlign: TextAlign.center,));
              _widgets.add(Image.asset('assets/images/Ricardo.png', width: 200, height: 200,));
            }
          } else {
            return 'No quedan intentos restantes.\nReinicia para volver a intentar';
          }
          return null;
        },
        decoration: InputDecoration(
            icon: const Icon(Icons.person),
            hintText: 'El número se encuentra entre 1 y 100',
            labelText: 'Introduzca $fieldName'),
        controller: controller);
  }


  @override
  Widget build(BuildContext context) {
    numRandom = getRandomNumber();
    numIntentos = 10;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Formulario"),
        ),
        drawer: const SideDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: _widgets,
            )
          )
        )
    );
  }
}