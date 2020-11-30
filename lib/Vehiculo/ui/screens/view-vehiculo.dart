import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/Vehiculo/ui/widgets/list-mantenimientos.dart';
import 'package:autolog/Vehiculo/ui/widgets/list-registro-mantenimientos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewVehiculo extends StatelessWidget {

  final String idVehiculo; 
  final User user = FirebaseAuth.instance.currentUser;
  String marca = '';
  String modelo = '';

  ViewVehiculo({Key key, this.idVehiculo, this.marca, this.modelo}): super(key: key){
    print(marca);
    print(modelo);
  }
  
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(marca + " " + modelo),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 22.0),
            tabs: [
              Tab(text: 'Notificaciones',),
              Tab(text: 'Registro',),
            ],
          ),
          
        ),
        body:  TabBarView(
          children: [
            ListMantenimientos(idVehiculo: idVehiculo,),
            ListRegistroMantenimientos(idVehiculo: idVehiculo,),
          ],
        ),
      ),
    ); 
  }


}