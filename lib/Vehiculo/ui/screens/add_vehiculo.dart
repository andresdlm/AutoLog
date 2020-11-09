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
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40, left: 5.0),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 45,),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
                  child: TitleHeader(title: "Crea un Vehiculo"),
                )
              )
            ],
          ),
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
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: TextInput(
              hintText: "Kilometraje",
              inputType: null,
              maxLines: 1,
              controller: _controllerKilometraje,
            ),
          ),
          Container(
            width: 350.0,
            child: ButtonBlue(
              buttonText: "Agregar Vehiculo",
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
          )
        ],
      ),
    );
  }
}