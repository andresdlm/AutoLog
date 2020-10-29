import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {

  @override
  State createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    return signInGoogleUI();
  }

  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          //Fondo
          Column(
            children: <Widget>[
              Text("Bienvenido!\nInicia sesion",
              style: TextStyle(
                fontSize: 37.0,
                fontFamily: "Lato",
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
              )
            ],
          )
        ],
      ),
    );
  }
}