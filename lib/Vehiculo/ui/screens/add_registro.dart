import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/mantenimiento.dart';
import 'package:autolog/Vehiculo/model/registro.dart';
import 'package:autolog/widgets/button_blue.dart';
import 'package:autolog/widgets/text_input.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hexcolor/hexcolor.dart';

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

  bool isNumeric(String s) {
    if (s == null) {
      return true;
    }
    return int.tryParse(s) != null;
  }

  final globalKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    // TODO: implement buil

    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    final _controllerTipoMantenimiento = TextEditingController()..text = "";
    final _controllerKilometrajeMantenimiento = TextEditingController();
    final _controllerfechaRealizado = TextEditingController()..text = "";
    final _controllerPrecioServicio = TextEditingController();
    final _controllerdescripcion = TextEditingController()..text = "";

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: TitleHeader(title: "Registrar Servicio", fontSize: 20,),
        backgroundColor: HexColor('#367EC2'),
        elevation: 8,
        leading: IconButton(
          padding: EdgeInsets.only(left: 10),
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 50,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: HexColor('#0A4A85'),
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
                labelText: "Fecha",
                hintText: "día/mes/año",
                inputType: null,
                maxLines: 1,
                controller: _controllerfechaRealizado,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                labelText: "Costo",
                hintText: "...",
                inputType: null,
                maxLines: 1,
                controller: _controllerPrecioServicio,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextInput(
                labelText: "Descripcion",
                hintText: "...",
                inputType: null,
                maxLines: 1,
                controller: _controllerdescripcion,
              ),
            ),
            Container(
              width: 350.0,
              child: ButtonBlue(
                buttonText: "Agregar Registro",
                colores: [
                          Colors.red[600],
                          Colors.pink[800],
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