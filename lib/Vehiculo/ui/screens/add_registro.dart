import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/mantenimiento.dart';
import 'package:autolog/Vehiculo/model/registro.dart';
import 'package:autolog/widgets/button_blue.dart';
import 'package:autolog/widgets/text_input.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class AddRegistroScreen extends StatefulWidget {
final String idVehiculo;
  AddRegistroScreen({Key key, this.idVehiculo}){
    print(idVehiculo);
  }

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddRegistroScreen(idVehiculo: idVehiculo);
  }
}

class _AddRegistroScreen extends State<AddRegistroScreen>{
  final String idVehiculo;

  _AddRegistroScreen({this.idVehiculo});
  @override
  int _value = 3;
  Widget build(BuildContext context) {
    // TODO: implement buil

    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    final _controllerTipoMantenimiento = TextEditingController();
    final _controllerKilometrajeMantenimiento = TextEditingController();
    final _controllerfechaRealizado = TextEditingController();
    final _controllerPrecioServicio = TextEditingController();
    final _controllerdescripcion = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: TitleHeader(title: "Registrar servicio"),
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

              // Dropdown de tipo de mantenimiento
              child: DropdownButton(
                
                value: _value,
                items: [
                    DropdownMenuItem(
                      child: Text("First Item"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Second Item"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("Third Item"),
                      value: 3
                    ),
                    DropdownMenuItem(
                        child: Text("Fourth Item"),
                        value: 4
                    )
                ],
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                }
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "Tipo de mantenimiento",
                inputType: null,
                maxLines: 1,
                controller: _controllerTipoMantenimiento,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "Kilometraje del servicio",
                inputType: null,
                maxLines: 1,
                controller: _controllerKilometrajeMantenimiento,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "Fecha",
                inputType: null,
                maxLines: 1,
                controller: _controllerfechaRealizado,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "Costo",
                inputType: null,
                maxLines: 1,
                controller: _controllerPrecioServicio,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                hintText: "Descripcion",
                inputType: null,
                maxLines: 1,
                controller: _controllerdescripcion,
              ),
            ),
            Container(
              width: 350.0,
              child: ButtonBlue(
                buttonText: "Agregar Registro",
                onPressed: () {
                  userBloc.addRegistro(
                    Registro(
                      tipoMantenimiento: _controllerTipoMantenimiento.text,
                      kilometrajeMantenimiento: int.parse(_controllerKilometrajeMantenimiento.text),
                      fechaRealizado: _controllerfechaRealizado.text,
                      precioServicio: int.parse(_controllerPrecioServicio.text),
                      descripcion: _controllerdescripcion.text
                    ), 
                    idVehiculo,
                    //idMantenimiento
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