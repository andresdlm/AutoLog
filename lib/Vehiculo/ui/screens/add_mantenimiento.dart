import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/mantenimiento.dart';
import 'package:autolog/widgets/button_blue.dart';
import 'package:autolog/widgets/text_input.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class AddMantenimientoScreen extends StatefulWidget {
final String idVehiculo;
  AddMantenimientoScreen({Key key, this.idVehiculo}){
    print(idVehiculo);
  }

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddMantenimientoScreen(idVehiculo: idVehiculo);
  }
}

class _AddMantenimientoScreen extends State<AddMantenimientoScreen>{
  final String idVehiculo;
  _AddMantenimientoScreen({this.idVehiculo});


  @override
  int _value = 1;
  String _controllerTipoMantenimiento = 'Cambio de Aceite';
  Widget build(BuildContext context) {
    // TODO: implement build

    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    final _controllerFrecuenciaKM = TextEditingController();
    final _controllerUltimoServicio = TextEditingController();
    final _controllerDescripcion = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: TitleHeader(title: "Agregar mantenimiento", fontSize: 26,),
        backgroundColor: Colors.white,
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
                        case 1: {_controllerTipoMantenimiento = "Cambio de Aceite";} break;
                        case 2: {_controllerTipoMantenimiento = "Frenos";} break;
                        case 3: {_controllerTipoMantenimiento = "Cauchos";} break;
                        case 4: {_controllerTipoMantenimiento = "Bateria";} break;
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
                controller: _controllerFrecuenciaKM,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "... km",
                labelText: "Ultimo Servicio km",
                inputType: null,
                maxLines: 1,
                controller: _controllerUltimoServicio,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "...",
                labelText: "Descripción",
                inputType: null,
                maxLines: 1,
                controller: _controllerDescripcion,
              ),
            ),
            Container(
              width: 350.0,
              child: ButtonBlue(
                buttonText: "Agregar Mantenimiento",
                onPressed: () {
                  userBloc.addMantenimiento(
                    Mantenimiento(
                      tipoMantenimiento: _controllerTipoMantenimiento,
                      frecuenciaMantenimiento: int.parse(_controllerFrecuenciaKM.text),
                      ultimoServicio: int.parse(_controllerUltimoServicio.text),
                      descripcion: _controllerDescripcion.text
                    ), 
                    idVehiculo
                  );
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