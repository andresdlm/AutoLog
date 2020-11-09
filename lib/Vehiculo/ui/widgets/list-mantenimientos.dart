import 'package:autolog/Vehiculo/ui/screens/add_mantenimiento.dart';
import 'package:flutter/material.dart';

class ListMantenimientos extends StatelessWidget {
  final String idVehiculo;

  ListMantenimientos({Key key, this.idVehiculo}): super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          height: 100.0,
          width: 100.0,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: FloatingActionButton(
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddMantenimientoScreen(idVehiculo: idVehiculo,)));
              },
              child: Icon(Icons.add, size: 40),
              backgroundColor: Color(0xFF2196F3),
              elevation: 10.0,
              ) 
          ),
      ),
          
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
