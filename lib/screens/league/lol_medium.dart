import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/themes.dart';
import '../side_drawer.dart';

class MediumLol extends StatelessWidget {
  const MediumLol({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medium Mode',
      theme: Themes().Default(),
      home: MediumForm(),
    );
  }
}

class MediumForm extends StatefulWidget {
  const MediumForm({super.key});

  @override
  State<MediumForm> createState() => FormWidget2();
}

class FormWidget2 extends State<MediumForm> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _textEditingControllers = [];
  List<Widget> _widgets = [];

  FormWidget2() {
    _generarCamposBase();
  }

  void _generarCamposBase() {
    List<List> fieldNames = [
      ["Name", TextInputType.name],
      ["Price", TextInputType.number],
      ["Tier", TextInputType.text],
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

  
  Column _createTextFormField(String fieldName, TextEditingController controller, TextInputType textType) {
    return Column (
      children: [
        Text(fieldName, style: GoogleFonts.balthazar(letterSpacing: 2, fontSize: 20, fontWeight: FontWeight.bold)),
        TextFormField(
          style: GoogleFonts.balthazar(
            letterSpacing: 2.0,
            fontSize: 20,
            color: Colors.white
          ),
          keyboardType: textType,
          obscureText: fieldName == "Contraseña",
          validator: (value) {
            if (value!.isEmpty) {
              return 'Field must be completed';
            } 
            return null;
          },
          decoration: InputDecoration(
            labelStyle: GoogleFonts.balthazar(fontSize: 20),
            hintStyle: GoogleFonts.balthazar(fontSize: 20),
            hintText: "· · ·",
            labelText: fieldName,
          ),
          controller: controller,
        )
      ]
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Medium Mode",
              style: GoogleFonts.kenia(
                letterSpacing: 2.0,
                fontSize: 50,
                fontWeight: FontWeight.bold
              ),
            ), centerTitle: true,),
    drawer: const SideDrawer(),
    bottomNavigationBar: ElevatedButton(
              onPressed: () {
                _formKey.currentState?.validate();
              },
              child: Text('Confirm',
                style: GoogleFonts.balthazar(
                  letterSpacing: 2.0,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 4),
              margin: EdgeInsets.fromLTRB(125, 0, 125, 0),
              decoration: BoxDecoration(
                    color: Colors.cyan,
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 0, 0)
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network("https://ddragon.leagueoflegends.com/cdn/12.6.1/img/item/3111.png", scale: 0.5, width: 100, height: 100,),
                  SizedBox(height: 5,),
                  Text("Id: 3110",
                    style: GoogleFonts.balthazar(
                      letterSpacing: 2.0,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    )
                  )
                ]
              )
            ),
            Container(width: 1, height: 2, color: Colors.cyan, margin: EdgeInsets.all(20),),
            ..._widgets, // los campos base
          ],
        ),
      ),
    ),
  );
}
}