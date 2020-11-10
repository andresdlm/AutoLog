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
        title: TitleHeader(title: "Agregar Vehiculo"),
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
      )
    );
  }
}