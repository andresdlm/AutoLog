import 'package:flutter/material.dart';

class ButtonAgregarVehiculo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Navegando"),
          )
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 30.0,
          left: 20.0,
          right: 20.0
        ),
        height: 50.0,
        width: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFF584CD1)
        ),
        child: Center(
          child: Text(
            "Agregar Vehiculo",
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: "Lato",
              color: Colors.white
            ),
          ),
        ),
      )
    );
  }
}