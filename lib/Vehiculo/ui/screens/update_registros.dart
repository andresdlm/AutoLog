import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/registro.dart';
import 'package:autolog/widgets/button_blue.dart';
import 'package:autolog/widgets/text_input.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UpdateRegistrosScreen extends StatefulWidget {
  
  final String idRegistro;
  final String idVehiculo; 
  final String tipoMantenimiento; 
  final int  kilometrajeMantenimiento;
  final String  fechaRealizado; 
  final int precioServicio; 
  final String descripcion; 
  
  UpdateRegistrosScreen({Key key, this.idRegistro, this.idVehiculo, this.tipoMantenimiento, this.kilometrajeMantenimiento, this.fechaRealizado, this.precioServicio ,this.descripcion});   //constructor

  _UpdateRegistrosScreenState createState() => _UpdateRegistrosScreenState(key: this.key, idRegistro: this.idRegistro,  idVehiculo: this.idVehiculo, tipoMantenimiento: this.tipoMantenimiento, kilometrajeMantenimiento: this.kilometrajeMantenimiento, fechaRealizado: fechaRealizado, precioServicio: this.precioServicio, descripcion: this.descripcion);
}


class _UpdateRegistrosScreenState extends State<UpdateRegistrosScreen> {

  final String idRegistro;
  final String idVehiculo; 
  final String tipoMantenimiento; 
  final int  kilometrajeMantenimiento;
  final String  fechaRealizado; 
  final int precioServicio; 
  final String descripcion; 

  _UpdateRegistrosScreenState({Key key, this.idRegistro, this.idVehiculo, this.tipoMantenimiento, this.kilometrajeMantenimiento, this.fechaRealizado, this.precioServicio, this.descripcion});  //constructor

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    
    final _controllerTipoMantenimiento = TextEditingController()..text = tipoMantenimiento;
    final _controllerKilometrajeMantenimiento = TextEditingController()..text = kilometrajeMantenimiento.toString();
    final _controllerfechaRealizado = TextEditingController()..text = fechaRealizado;
    final _controllerPrecioServicio = TextEditingController()..text = precioServicio.toString();
    final _controllerdescripcion = TextEditingController()..text = descripcion;


    return Scaffold(
      appBar: AppBar(
        title: TitleHeader(title: "Editar Registro", fontSize: 20,),
        backgroundColor: Colors.blue[400],
        elevation: 8,
        leading: IconButton(
          padding: EdgeInsets.only(left: 10),
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 50,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.blue[200],
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 5),
              child: TextInput(
                labelText: "Tipo de mantenimiento",
                hintText: "...",
                inputType: null,
                maxLines: 1,
                controller: _controllerTipoMantenimiento,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                labelText: "Kilometraje del servicio",
                hintText: "... km",
                inputType: null,
                maxLines: 1,
                controller: _controllerKilometrajeMantenimiento,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                labelText: "Fecha realizado",
                hintText: "yy, mm, dd",
                inputType: null,
                maxLines: 1,
                controller: _controllerfechaRealizado,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                labelText: "Costo del servicio",
                hintText: "...",
                inputType: null,
                maxLines: 1,
                controller: _controllerPrecioServicio,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                labelText: "Descripción",
                hintText: "...",
                inputType: null,
                maxLines: 1,
                controller: _controllerdescripcion,
              ),
            ),
            
            Container(
              width: 350.0,
              child: ButtonBlue(
                buttonText: "Guardar Cambios",
                colores: [
                              Colors.blue[600],
                              Colors.indigo[400],
                          ],
                onPressed: () {
                  userBloc.updateRegistro(Registro(tipoMantenimiento: _controllerTipoMantenimiento.text,
                                                  kilometrajeMantenimiento: int.parse(_controllerKilometrajeMantenimiento.text),
                                                  fechaRealizado: _controllerfechaRealizado.text,
                                                  descripcion: _controllerdescripcion.text,
                                                  precioServicio: int.parse(_controllerPrecioServicio.text)),
                                                  idVehiculo,
                                                  idRegistro);
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      )
    );
  }
}