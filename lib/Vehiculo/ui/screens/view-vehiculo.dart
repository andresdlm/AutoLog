import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/Vehiculo/ui/widgets/list-mantenimientos.dart';
import 'package:autolog/Vehiculo/ui/widgets/list-registro-mantenimientos.dart';
import 'package:flutter/material.dart';

class ViewVehiculo extends StatefulWidget {

  @override
  State createState() {
    return _ViewVehiculo();
  }
}

class _ViewVehiculo extends State<ViewVehiculo> {

  String marca = "Ford";
  String modelo = "Ranger";
  String color = "Blanco";
  
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(marca + ' ' + modelo),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Mantenimientos'),
              Tab(text: 'Registro',),
            ],
          ),
          
        ),
        body:  TabBarView(
          children: [
            ListMantenimientos(),
            ListRegistroMantenimientos(),
          ],
        ),
      ),
    ); 
  }
}