import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/registro.dart';
import 'package:autolog/widgets/button_blue.dart';
import 'package:autolog/widgets/text_input.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hexcolor/hexcolor.dart';

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

    bool isNumeric(String s) {
    if (s == null) {
      return true;
    }
    return int.tryParse(s) != null;
  }

  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    
    final _controllerTipoMantenimiento = TextEditingController()..text = tipoMantenimiento;
    final _controllerKilometrajeMantenimiento = TextEditingController()..text = kilometrajeMantenimiento.toString();
    final _controllerfechaRealizado = TextEditingController()..text = fechaRealizado;
    final _controllerPrecioServicio = TextEditingController()..text = precioServicio.toString();
    final _controllerdescripcion = TextEditingController()..text = descripcion;


    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: TitleHeader(title: "Editar Registro", fontSize: 20,),
        backgroundColor: HexColor('#367EC2'),
        elevation: 8,
        leading: IconButton(
          padding: EdgeInsets.only(left: 10),
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 50,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: HexColor('#7FA4C3'),
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
                hintText: "día/mes/año",
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
                  
                  if(_controllerTipoMantenimiento.text == "" || isNumeric(_controllerTipoMantenimiento.text) == true){
                      final snackBar = SnackBar(content: Text('Error! Ingrese el "Tipo de mantenimiento"'));
                      globalKey.currentState.showSnackBar(snackBar);
                  }
                  else if(isNumeric(_controllerKilometrajeMantenimiento.text) == false){
                      final snackBar = SnackBar(content: Text('Error! Ingrese el "Kilometraje" cuando hizo el servicio'));
                      globalKey.currentState.showSnackBar(snackBar);
                  }
                  else if (_controllerfechaRealizado.text == "" || isNumeric(_controllerfechaRealizado.text) == true) {
                      final snackBar = SnackBar(content: Text('Error! Ingrese la "Fecha" cuando hizo el servicio')); //final snackBar = SnackBar(content: Text('Profile saved'), action: SnackBarAction(label: 'Undo', onPressed: (){},),
                      globalKey.currentState.showSnackBar(snackBar);
                  }
                  else if(isNumeric(_controllerPrecioServicio.text) == false){
                      final snackBar = SnackBar(content: Text('Error! El "Precio" debe ser un número'));
                      globalKey.currentState.showSnackBar(snackBar);
                  }
                  else{
                  userBloc.updateRegistro(Registro(tipoMantenimiento: _controllerTipoMantenimiento.text,
                                                  kilometrajeMantenimiento: int.parse(_controllerKilometrajeMantenimiento.text),
                                                  fechaRealizado: _controllerfechaRealizado.text,
                                                  descripcion: _controllerdescripcion.text,
                                                  precioServicio: int.parse(_controllerPrecioServicio.text)),
                                                  idVehiculo,
                                                  idRegistro);
                  Navigator.pop(context);
                  }
                },
              ),
            )
          ],
        ),
      )
    );
  }
}