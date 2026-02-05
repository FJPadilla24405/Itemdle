import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_routes.dart';
import '../../themes/themes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LoginScreen',
        theme: Temas().Default(),
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/HomeBackground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          child: Center(
             child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: 20,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Itemdle",
                          style: GoogleFonts.kenia(
                          fontSize: 50,
                        ), softWrap: true,
                        textAlign: TextAlign.center,),
                      Image.asset("assets/images/ItemSquareWorld_Atlas.png", width: 200,)
                    ],
                  ),
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.5,
                  alignment: Alignment(0, 0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    border: Border.all(
                      width: 10,
                      color: Color.fromRGBO(255, 255, 255, 0.15)
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Username",
                          style: GoogleFonts.balthazar(
                          fontSize: 19,
                        ), softWrap: true,
                        textAlign: TextAlign.center,),
                        // Name text field
                        Text("Password",
                          style: GoogleFonts.balthazar(
                          fontSize: 19,
                        ), softWrap: true,
                        textAlign: TextAlign.center,),
                        // Password text field
                        ElevatedButton(onPressed: () {
                          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                        }, child:
                          Text("Enter",
                          style: GoogleFonts.balthazar(
                          fontSize: 19,
                          ), softWrap: true,
                          textAlign: TextAlign.center,))
                      ],
                    )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 150),
                )
              ],)
          ),
        ))));
  }
}