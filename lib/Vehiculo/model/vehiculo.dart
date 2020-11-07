  import 'package:flutter/material.dart';
import 'package:autolog/Usuario/model/usuario.dart';

class Vehiculo {
  String id;
  String marca;
  String modelo;
  int year;
  String color;
  int kilometraje;
  //User userOwner;

  
  Vehiculo({
    Key key,
    this.id,
    @required this.marca,
    @required this.modelo,
    @required this.year,
    @required this.color,
    @required this.kilometraje,
    //@required this.userOwner
  });
  
}