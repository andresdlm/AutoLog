import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/Vehiculo/ui/widgets/list-mantenimientos.dart';
import 'package:autolog/Vehiculo/ui/widgets/list-registro-mantenimientos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewVehiculo extends StatelessWidget {

  final String idVehiculo; 
  final User user = FirebaseAuth.instance.currentUser;

  String marca = "Ford";
  String modelo = "Ranger";
  String color = "Blanco";

  ViewVehiculo({Key key, this.idVehiculo}): super(key: key) {
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car');
    Future<DocumentSnapshot> car = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).get();
    car.then((DocumentSnapshot carSnapshot) => {
      print(carSnapshot['marca']),
      print(carSnapshot['modelo']),
      print(carSnapshot['color']),
      print(carSnapshot['year']),
      print(carSnapshot['km']),
    });
  }
  
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