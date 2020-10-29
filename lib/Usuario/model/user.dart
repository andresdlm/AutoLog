import 'package:flutter/material.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final List<Vehiculo> misVehiculos;

  User({
    Key key,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.photoURL,
    this.misVehiculos
  });

}