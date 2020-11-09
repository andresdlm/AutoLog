import 'package:flutter/material.dart';


class Registro {
  String tipoMantenimiento;
  int kilometrajeMantenimiento;
  String fechaRealizado;
  int precioServicio;
  String descripcion;
 
  Registro({
    Key key,
    @required this.tipoMantenimiento,
    @required this.kilometrajeMantenimiento,
    @required this.fechaRealizado,
    @required this.precioServicio,
    @required this.descripcion,
  });


}