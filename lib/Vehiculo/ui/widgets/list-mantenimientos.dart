import 'package:autolog/Vehiculo/ui/screens/add_mantenimiento.dart';
import 'package:flutter/material.dart';

class ListMantenimientos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddMantenimientoScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF2196F3),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}