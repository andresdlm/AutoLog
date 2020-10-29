import 'package:autolog/Vehiculo/ui/widgets/buttonAgregarVehiculo.dart';
import 'package:flutter/material.dart';
import 'package:autolog/Vehiculo/ui/widgets/bannerVehiculo.dart';

class ListVehiculos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: 20.0,
            left:20.0,
            right: 20.0
          ),
          child: Row(
            children: [
              Text(
                "Mis Vehiculos",
                style: TextStyle(
                  fontFamily: "Lato",
                  fontSize: 26.0,
                  fontWeight: FontWeight.w900
                ),
              textAlign: TextAlign.left,
              ),
              ButtonAgregarVehiculo()
            ],
          )
        ),
        BannerVehiculo("Mazda", "6", 2008, "negro", 130000),
        BannerVehiculo("Jeepeta", "Grand Cherokee", 2009, "negro", 130000),
      ],  
    );
  }

}