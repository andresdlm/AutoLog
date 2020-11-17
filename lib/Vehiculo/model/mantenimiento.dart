import 'package:flutter/material.dart';


class Mantenimiento {
  String tipoMantenimiento;
  int frecuenciaMantenimiento;
  int ultimoServicio;
  String descripcion;
  bool estadoNotificacion; 
 
  Mantenimiento({
    Key key,
    @required this.tipoMantenimiento,
    @required this.frecuenciaMantenimiento,
    @required this.ultimoServicio,
    @required this.descripcion, 
              this.estadoNotificacion,
  });


}