import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../side_drawer.dart';

class Enlace11 extends StatelessWidget {
  const Enlace11({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Pantalla());
  }
}

class Pantalla extends StatefulWidget {
  const Pantalla({super.key});

  @override
  State<Pantalla> createState() => PantallaInstagram();
}

class PantallaInstagram extends State<Pantalla>{
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram',
        home: Scaffold(
          appBar: AppBar(
            title: const Text("FranciscoPadilla"),
            centerTitle: true,
          ),
          drawer: const SideDrawer(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/RedHarlow.jpg'),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("1,026",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text("Posts")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("8.2 M",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text("Followers")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("1,754",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        Text("Following")
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.all(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("ColourPop Cosmetics", style: TextStyle(fontWeight: FontWeight.bold)),
                        const Text("Health/Beauty", style: TextStyle(color: Colors.grey)),
                        const Text("Made in LA ⚡"),
                        const Text("Cruelty Free 🐶"),
                        const Text("#ColourPopMe", style: TextStyle(color: Colors.blue)),
                        InkWell(
                          child: Text('bit.ly/2w9g74q',
                          style: TextStyle(
                          color: Colors.blue
                          ), textAlign: TextAlign.center,),
                          onTap: () => launchUrl(Uri.parse('https://colourpop.com/?utm_source=IG&utm_medium=Social&utm_campaign=Bio'))
                        ),
                        RichText(text: const TextSpan(
                          style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                          children: <TextSpan>[
                          TextSpan(text: 'Followed by '),
                          TextSpan(text: 'sejiexx, thedailyconcealer', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                        )),
                        RichText(text: const TextSpan(
                          style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                          children: <TextSpan>[
                          TextSpan(text: 'and '),
                          TextSpan(text: '22 others', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                        )),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color.fromARGB(255, 214, 214, 214), 
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          minimumSize: Size(100, 35)),
                      child: const Text(
                        "Following v",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color.fromARGB(255, 214, 214, 214),
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          minimumSize: Size(100, 35)),
                      child: const Text(
                        "Message",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color.fromARGB(255, 214, 214, 214),
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          minimumSize: Size(100, 35)),
                      child: const Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color.fromARGB(255, 214, 214, 214),
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          minimumSize: Size(10, 35)),
                      child: const Text(
                        "v",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(45, 0, 45, 0)),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/Ricarda.png'),
                        ),
                        Text("ARTIST TAK...")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(45, 0, 45, 0)),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/RicardoElegante.png'),
                        ),
                        Text("YOUTUBE")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(45, 0, 45, 0)),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/cesped.jpg'),
                        ),
                        Text("LUX LIPSTI...")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(45, 0, 45, 0)),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/RicardoNavidad.png'),
                        ),
                        Text("BTS")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(45, 0, 45, 0)),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/Ricardo.png'),
                        ),
                        Text("CONCERTS")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(45, 0, 45, 0)),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/RicardoFiestas.png'),
                        ),
                        Text("PARTIES")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(45, 0, 45, 0)),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/RicardoPelo.png'),
                        ),
                        Text("SCENERY")
                      ],
                    ),
                  ],
                ),),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.grid_on_outlined),
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    shadowColor: Colors.black,
                                    elevation: 3,
                                    shape: const BeveledRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1))),
                                    minimumSize: Size((screenWidth/4), 50)),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.tv),
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    shadowColor: Colors.black,
                                    elevation: 3,
                                    shape: const BeveledRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1))),
                                    minimumSize: Size((screenWidth/4), 50)),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.cases_outlined),
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    shadowColor: Colors.black,
                                    elevation: 3,
                                    shape: const BeveledRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1))),
                                    minimumSize: Size((screenWidth/4), 50)),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.account_box_outlined),
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    shadowColor: Colors.black,
                                    elevation: 3,
                                    shape: const BeveledRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1))),
                                    minimumSize: Size((screenWidth/4), 50)),
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: screenWidth,
                                height: 350,
                                child: GridView.count(
                                  crossAxisCount: 3,
                                  children: [
                                    Image.asset('assets/images/Ricardo.png'),
                                    Image.asset('assets/images/Ricarda.png'),
                                    Image.asset('assets/images/RicardoElegante.png'),
                                    Image.asset('assets/images/RicardoFiestas.png'),
                                    Image.asset('assets/images/RicardoNavidad.png'),
                                    Image.asset('assets/images/RicardoPelo.png'),
                                    Image.asset('assets/images/Ricardo.png'),
                                    Image.asset('assets/images/RedHarlow.jpg'),
                                    Image.asset('assets/images/cesped.jpg'),
                                  ],
                                ))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.black), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.add, color: Colors.black), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_outline, color: Colors.black), label: ''),
              BottomNavigationBarItem(icon: CircleAvatar(radius: 20, backgroundImage: AssetImage('assets/images/RedHarlow.jpg')), label: '')
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }
}