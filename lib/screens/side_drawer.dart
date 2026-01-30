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
        ],
      ),
    );
  }
}