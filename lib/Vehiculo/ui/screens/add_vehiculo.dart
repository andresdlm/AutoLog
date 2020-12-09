import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/widgets/button_blue.dart';
import 'package:autolog/widgets/text_input.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hexcolor/hexcolor.dart';

class AddVehiculoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddVehiculoScreen();
  }
}

class _AddVehiculoScreen extends State<AddVehiculoScreen> {
  @override

  bool isNumeric(String s) {
  if (s == null) {
    return true;
  }
  return int.tryParse(s) != null;
  }

  final globalKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    // TODO: implement build

    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    final _controllerMarca = TextEditingController()..text = "";
    final _controllerModelo = TextEditingController()..text = "";
    final _controllerYear = TextEditingController();
    final _controllerColor = TextEditingController()..text = "";
    final _controllerKilometraje = TextEditingController();

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: TitleHeader(title: "Agregar Vehiculo", fontSize: 20),
        backgroundColor: HexColor('#367EC2'),
        elevation: 8,
        leading: IconButton(
          padding: EdgeInsets.only(left: 10),
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 50,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: HexColor('#0A4A85'), //1D2B47 
        child:  new ListView(
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
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: TextInput(
                      labelText: "Kilometraje",
                      hintText: "... km",
                      inputType: null,
                      maxLines: 1,
                      controller: _controllerKilometraje,
                    ),
                  ),
                  Container(
                    child: ButtonBlue(
                      buttonText: "Agregar Vehiculo",
                      colores: [
                          Colors.red[600],
                          Colors.pink[800],
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
                            //final snackBar = SnackBar(content: Text('Profile saved'), action: SnackBarAction(label: 'Undo', onPressed: (){},),
                            globalKey.currentState.showSnackBar(snackBar);
                        }
                        else if(_controllerColor.text == "" || isNumeric(_controllerColor.text) == true){
                            final snackBar = SnackBar(content: Text('Error! Ingrese un "Color"'));
                            globalKey.currentState.showSnackBar(snackBar);
                        }
                        else if(isNumeric(_controllerKilometraje.text) == false){
                            final snackBar = SnackBar(content: Text('Error! El "Kilometraje" debe ser un número entero'));
                            globalKey.currentState.showSnackBar(snackBar);
                        }
                        else{
                          userBloc.createVehiculo(Vehiculo(
                            marca: _controllerMarca.text,
                            modelo: _controllerModelo.text,
                            year: int.parse(_controllerYear.text),
                            color: _controllerColor.text,
                            kilometraje: int.parse(_controllerKilometraje.text),
                          ));
                          Navigator.pop(context);
                        }
                      
                      },
                    ),
                  ),
            ],
        )
      ) 
    );
  }
}