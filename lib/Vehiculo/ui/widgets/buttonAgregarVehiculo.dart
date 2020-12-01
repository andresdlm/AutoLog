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
        height: 55.0,
        width: 170.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
              colors: [
                Colors.red[600],
                Colors.pink[800],
              ],
              begin: FractionalOffset(0.2, 0.0),
              end: FractionalOffset(1.0, 1.9),
              stops: [0.0, 0.8],
              tileMode: TileMode.clamp

            )
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