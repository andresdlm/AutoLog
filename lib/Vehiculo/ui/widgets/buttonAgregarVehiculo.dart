import 'package:autolog/Vehiculo/ui/screens/add_vehiculo.dart';
import 'package:flutter/material.dart';

class ButtonAgregarVehiculo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddVehiculoScreen())
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 30.0,
          left: 20.0,
          right: 20.0
        ),
        height: 50.0,
        width: 130.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.orange[600]
        ),
        child: Center(
          child: Text(
            "Agregar",
            style: TextStyle(
              fontSize: 21.0,
              fontFamily: "Lato",
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      )
    );
  }
}