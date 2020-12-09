import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/widgets/button_blue.dart';
import 'package:autolog/widgets/text_input.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hexcolor/hexcolor.dart';

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

    final _controllerMarca = TextEditingController()..text = marca;
    final _controllerModelo = TextEditingController()..text = modelo;
    final _controllerYear = TextEditingController()..text = year;
    final _controllerColor = TextEditingController()..text = color;

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: TitleHeader(title: "Editar Vehiculo", fontSize: 20,),
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
                labelText: "Marca",
                hintText: "...",
                inputType: null,
                maxLines: 1,
                controller: _controllerMarca,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                labelText: "Modelo",
                hintText: "...",
                inputType: null,
                maxLines: 1,
                controller: _controllerModelo,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                labelText: "Año",
                hintText: "...",
                inputType: null,
                maxLines: 1,
                controller: _controllerYear,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                labelText: "Color",
                hintText: "...",
                inputType: null,
                maxLines: 1,
                controller: _controllerColor,
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
                    if(_controllerMarca.text == "" || isNumeric(_controllerMarca.text) == true){
                        final snackBar = SnackBar(content: Text('Error! Ingrese la "Marca" del carro'));
                        globalKey.currentState.showSnackBar(snackBar);
                    }
                     else if(_controllerModelo.text == "" || isNumeric(_controllerModelo.text) == true){
                        final snackBar = SnackBar(content: Text('Error! Ingrese el "Modelo" del carro'));
                        globalKey.currentState.showSnackBar(snackBar);
                     }
                    else if (isNumeric(_controllerYear.text) == false) {
                        final snackBar = SnackBar(content: Text('Error! El "Año" debe ser un número entero')); 
                        globalKey.currentState.showSnackBar(snackBar);
                    }
                    else if(_controllerColor.text == "" || isNumeric(_controllerColor.text) == true){
                        final snackBar = SnackBar(content: Text('Error! Ingrese un "Color"'));
                        globalKey.currentState.showSnackBar(snackBar);
                    }
                    else{
                        userBloc.updateVehiculo(Vehiculo( marca: _controllerMarca.text,
                                                        modelo: _controllerModelo.text,
                                                        year: int.parse(_controllerYear.text),
                                                        color: _controllerColor.text,) , idVehiculo);
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