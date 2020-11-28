import 'package:flutter/material.dart';

class Vehiculo {
  String id;
  String marca;
  String modelo;
  int year;
  String color;
  int kilometraje;
  int kilometrajeAnterior;
  //User userOwner;

  
  Vehiculo({
    Key key,
    this.id,
    @required this.marca,
    @required this.modelo,
    @required this.year,
    @required this.color,
    this.kilometraje,
    this.kilometrajeAnterior
    //@required this.userOwner
  });
  
}