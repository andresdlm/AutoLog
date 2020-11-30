import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/mantenimiento.dart';
import 'package:autolog/widgets/button_blue.dart';
import 'package:autolog/widgets/text_input.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UpdateMantenimientosScreen extends StatefulWidget {
  
  final String idMantenimiento;
  final String idVehiculo; 
  final String tipoMantenimiento; 
  final int  frecuenciaMantenimiento;
  final int ultimoServicio; 
  final String descripcion; 

  UpdateMantenimientosScreen({Key key, this.idMantenimiento, this.idVehiculo, this.tipoMantenimiento, this.frecuenciaMantenimiento, this.ultimoServicio, this.descripcion});   //constructor

  _UpdateMantenimientosScreenState createState() => _UpdateMantenimientosScreenState(key: this.key, idMantenimiento: this.idMantenimiento,  idVehiculo: this.idVehiculo, tipoMantenimiento: this.tipoMantenimiento, frecuenciaMantenimiento: this.frecuenciaMantenimiento, ultimoServicio: this.ultimoServicio, descripcion: this.descripcion);
}


class _UpdateMantenimientosScreenState extends State<UpdateMantenimientosScreen> {

  final String idMantenimiento;
  final String idVehiculo; 
  String tipoMantenimiento; 
  final int  frecuenciaMantenimiento;
  final int  ultimoServicio; 
  final String descripcion; 

  _UpdateMantenimientosScreenState({Key key, this.idMantenimiento, this.idVehiculo, this.tipoMantenimiento, this.frecuenciaMantenimiento, this.ultimoServicio, this.descripcion});  //constructor

  int _value;


  void selectTipoMantenimiento(){
    if(tipoMantenimiento == "Cambio de Aceite")
      _value = 1; 
    else if(tipoMantenimiento == "Frenos")
      _value = 2; 
    else if(tipoMantenimiento == "Cauchos")
      _value = 3; 
    else
      _value = 4; 
  }

  @override
  Widget build(BuildContext context) {
    selectTipoMantenimiento();
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    
    final _controllertipoMantenimiento = tipoMantenimiento; 
    final _controllerfrecuenciaMantenimiento = TextEditingController()..text = frecuenciaMantenimiento.toString();
    final _controllerultimoServicio = TextEditingController()..text = ultimoServicio.toString();
    final _controllerdescripcion = TextEditingController()..text = descripcion;

    return Scaffold(
      appBar: AppBar(
        title: TitleHeader(title: "Editar Notificación", fontSize: 20,),
        backgroundColor: Colors.blue[200],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 45,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 5),
              width: 350,
              height: 67,
              padding: EdgeInsets.only(left: 10.0),        
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
                border: Border.all(
                  color: Color(0xFFe5e5e5),
                  width: 3.0
                )
              ),      
              child: DropdownButton(
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Lato",
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold
                ),
                isExpanded: true,
                value: _value,
                items: [
                    DropdownMenuItem(
                      child: Text("Cambio de Aceite"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Frenos"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("Cauchos"),
                      value: 3
                    ),
                    DropdownMenuItem(
                        child: Text("Bateria"),
                        value: 4
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    _value = value;
                    switch(_value){
                        case 1: {tipoMantenimiento = "Cambio de Aceite";} break;
                        case 2: {tipoMantenimiento = "Frenos";} break;
                        case 3: {tipoMantenimiento = "Cauchos";} break;
                        case 4: {tipoMantenimiento = "Bateria";} break;
                    }
                    
                  });
                },  
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "... km",
                labelText: "Frecuencia km",
                inputType: null,
                maxLines: 1,
                controller: _controllerfrecuenciaMantenimiento,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "... km",
                labelText: "Ultimo Servicio km",
                inputType: null,
                maxLines: 1,
                controller: _controllerultimoServicio,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "...",
                labelText: "Descripción",
                inputType: null,
                maxLines: 1,
                controller: _controllerdescripcion,
              ),
            ),
            
            Container(
              width: 350.0,
              child: ButtonBlue(
                buttonText: "Guardar Cambios",
                onPressed: () {
                  userBloc.updateMantenimiento(Mantenimiento(tipoMantenimiento: _controllertipoMantenimiento,
                                                             frecuenciaMantenimiento: int.parse(_controllerfrecuenciaMantenimiento.text),
                                                             ultimoServicio: int.parse(_controllerultimoServicio.text),
                                                             descripcion: _controllerdescripcion.text,),
                                                             idVehiculo,
                                                             idMantenimiento);
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