import 'package:flutter/material.dart';

class BannerVehiculo extends StatelessWidget {

  String marca;
  String modelo;
  int year;
  String color;
  int kilometraje;

  BannerVehiculo(this.marca, this.modelo, this.year, this.color, this.kilometraje);

  @override
  Widget build(BuildContext context) {

    final descripcionVehiculo = Container(
      margin: EdgeInsets.only(
          left: 20.0,
          top: 5
      ),

      child: Text(
        year.toString() + "   " + color,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: "Lato",
            fontSize: 13.0,
            fontWeight: FontWeight.w900
        ),
      ),
    );

    final modeloVehiculo = Container(
      margin: EdgeInsets.only(
        left: 20.0
      ),

      child: Text(
        modelo,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: "Lato",
            fontSize: 13.0,
          color: Color.fromRGBO(144, 144, 144, 1)
        ),
      ),
    );

    final marcaVehiculo = Container(
      margin: EdgeInsets.only(
        left: 20.0,
        top: 10
      ),

      child: Text(
        marca,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: "Lato",
            fontSize: 17.0
        ),

      ),

    );

    final kilometrajeVehiculo = Container(
      margin: EdgeInsets.only(
        left: 20.0,
        top: 5
      ),

      child: Text(
        "Kilometraje: " + kilometraje.toString(),
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: "Lato",
            fontSize: 13.0,
          color: Color.fromRGBO(144, 144, 144, 1)
        ),
      ),
    );

    final userDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        marcaVehiculo,
        modeloVehiculo,
        descripcionVehiculo,
        kilometrajeVehiculo

      ],
    );

    final contenedor = Container(
      margin: EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0
      ),
      width: 300,
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromRGBO(229, 229, 229, 1),
        borderRadius:  BorderRadius.circular(20.0)
      ),
      child: userDetails, 
    );

    return contenedor;
  }
}