
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'screens.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text("ㅤDeveloped by Fco Padillaㅤ",
              style: TextStyle(color: Colors.white, backgroundColor: Colors.black),
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.clip,),
            accountEmail: InkWell(
              child: const Text('ㅤhttps://github.com/FJPadilla24405/RepositorioFlutterFcoPadillaㅤ',
                style: TextStyle(color: Colors.white, backgroundColor: Colors.black),
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.clip),
                onTap: () => launchUrl(Uri.parse('https://github.com/FJPadilla24405/RepositorioFlutterFcoPadilla'))
            ),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/DrawerImage.jpg'),
                    fit: BoxFit.cover)),
          ),
          Ink(
            color: Color.fromARGB(255, 0, 23, 53),
            child: ListTile(
              title: Text("Home",
                style: GoogleFonts.kenia(
                  letterSpacing: 2,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                )
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const HomeApp()));
              },
            ),
          ),
          ListTile(
            leading: Image.asset('assets/images/LeagueIcon.png', width: 30),
            title: Text("League of Legends",
            style: GoogleFonts.balthazar(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
            )),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const DifMenuLol()));
            },
          ),
          ListTile(
            title: const Text("Columna"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace3()));
            },
          ),
          ListTile(
            title: const Text("Iconos en fila"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace4()));
            },
          ),
          ListTile(
            title: const Text("Imágenes en columnas"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace5()));
            },
          ),
          ListTile(
            title: const Text("Texto en filas"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace6()));
            },
          ),
          ListTile(
            title: const Text("Imagenes repetidas"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace7()));
            },
          ),
          ListTile(
            title: const Text("Ejemplo responsive"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace8()));
            },
          ),
          ListTile(
            title: const Text("Challenge"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace9()));
            },
          ),
          ListTile(
            title: const Text("Contador de clicks"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace10()));
            },
          ),
          ListTile(
            title: const Text("Instagram"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace11()));
            },
          ),
          ListTile(
            title: const Text("Colores aleatorios"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace12()));
            },
          ),
          ListTile(
            title: const Text("Juego de clicks"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace13()));
            },
          ),
          ListTile(
            title: const Text("Adivinar número"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace14()));
            },
          ),
          ListTile(
            title: const Text("Formularios"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Enlace15()));
            },
          ),
          ListTile(
            title: const Text("Examen"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Pantalla1()));
            },
          ),
        ],
      ),
    );
  }
}