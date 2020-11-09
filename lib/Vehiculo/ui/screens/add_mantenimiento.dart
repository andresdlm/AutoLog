import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/mantenimiento.dart';
import 'package:autolog/widgets/button_blue.dart';
import 'package:autolog/widgets/text_input.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class AddMantenimientoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddMantenimientoScreen();
  }
}

class _AddMantenimientoScreen extends State<AddMantenimientoScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    final _controllerTipoMantenimiento = TextEditingController();
    final _controllerFrecuenciaKM = TextEditingController();
    final _controllerUltimoServicio = TextEditingController();
    final _controllerDescripcion = TextEditingController();

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
                  child: TitleHeader(title: "Agrega un mantenimiento"),
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
              controller: _controllerTipoMantenimiento,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: TextInput(
              hintText: "Modelo",
              inputType: null,
              maxLines: 1,
              controller: _controllerFrecuenciaKM,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: TextInput(
              hintText: "Año",
              inputType: null,
              maxLines: 1,
              controller: _controllerUltimoServicio,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: TextInput(
              hintText: "Color",
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
                    tipoMantenimiento: _controllerTipoMantenimiento.text,
                    frecuenciaMantenimiento: int.parse(_controllerTipoMantenimiento.text),
                    ultimoServicio: int.parse(_controllerUltimoServicio.text),
                    descripcion: _controllerDescripcion.text
                  ), 
                  "");
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}