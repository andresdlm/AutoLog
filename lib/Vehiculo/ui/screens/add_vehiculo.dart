import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/widgets/button_blue.dart';
import 'package:autolog/widgets/text_input.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class AddVehiculoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddVehiculoScreen();
  }
}

class _AddVehiculoScreen extends State<AddVehiculoScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    final _controllerMarca = TextEditingController();
    final _controllerModelo = TextEditingController();
    final _controllerYear = TextEditingController();
    final _controllerColor = TextEditingController();
    final _controllerKilometraje = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: TitleHeader(title: "Agregar Vehiculo", fontSize: 20,),
        backgroundColor: Colors.red[400],
        elevation: 8,
        leading: IconButton(
          padding: EdgeInsets.only(left: 10),
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 50,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.red[200],
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
                        userBloc.createVehiculo(Vehiculo(
                          marca: _controllerMarca.text,
                          modelo: _controllerModelo.text,
                          year: int.parse(_controllerYear.text),
                          color: _controllerColor.text,
                          kilometraje: int.parse(_controllerKilometraje.text),
                        ));
                        Navigator.pop(context);
                      },
                    ),
                  ),
            ],
        )
      ) 
    );
  }
}