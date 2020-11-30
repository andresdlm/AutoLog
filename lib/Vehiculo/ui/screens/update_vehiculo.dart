import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/widgets/button_blue.dart';
import 'package:autolog/widgets/text_input.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UpdateVehiculoScreen extends StatefulWidget {
  
  final String idVehiculo; 
  final String marca; 
  final String modelo;
  final String year; 
  final String color; 

  UpdateVehiculoScreen({Key key, this.idVehiculo, this.marca, this.modelo, this.year, this.color});   //constructor

  _UpdateVehiculoScreenState createState() => _UpdateVehiculoScreenState(key: this.key, idVehiculo: this.idVehiculo, modelo: this.modelo, marca: this.marca, year: this.year, color: this.color);
}


class _UpdateVehiculoScreenState extends State<UpdateVehiculoScreen> {

  final String idVehiculo; 
  final String marca; 
  final String modelo;
  final String year; 
  final String color; 

  _UpdateVehiculoScreenState({Key key, this.idVehiculo, this.marca, this.modelo, this.year, this.color});  //constructor



  @override
  Widget build(BuildContext context) {

    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    final _controllerMarca = TextEditingController()..text = marca;
    final _controllerModelo = TextEditingController()..text = modelo;
    final _controllerYear = TextEditingController()..text = year;
    final _controllerColor = TextEditingController()..text = color;

    return Scaffold(
      appBar: AppBar(
        title: TitleHeader(title: "Editar Vehiculo", fontSize: 20),
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
              child: TextInput(
                hintText: "Marca",
                inputType: null,
                maxLines: 1,
                controller: _controllerMarca,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "Modelo",
                inputType: null,
                maxLines: 1,
                controller: _controllerModelo,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "Año",
                inputType: null,
                maxLines: 1,
                controller: _controllerYear,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "Color",
                inputType: null,
                maxLines: 1,
                controller: _controllerColor,
              ),
            ),
            
            Container(
              width: 350.0,
              child: ButtonBlue(
                buttonText: "Guardar Cambios",
                onPressed: () {
                  
                  userBloc.updateVehiculo(Vehiculo( marca: _controllerMarca.text,
                                                   modelo: _controllerModelo.text,
                                                   year: int.parse(_controllerYear.text),
                                                   color: _controllerColor.text,) , idVehiculo);
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