import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/ui/widgets/buttonAgregarVehiculo.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:flutter/material.dart';
import 'package:autolog/Vehiculo/ui/widgets/bannerVehiculo.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ListVehiculos extends StatelessWidget {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    
    userBloc = BlocProvider.of<UserBloc>(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ButtonAgregarVehiculo(),
        TitleHeader(title: "Mis Vehículos",),
        StreamBuilder(
          stream: userBloc.vehiculosStream,
          builder: (context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                return Column(
                  children: userBloc.buildVehiculos(snapshot.data.documents)
                );
              case ConnectionState.active:
                return Column(
                  children: userBloc.buildVehiculos(snapshot.data.documents)
                );
              case ConnectionState.none:
                return CircularProgressIndicator();
              default:
                return Column(
                  children: userBloc.buildVehiculos(snapshot.data.documents)
                );
            }
          }
        )
        
        
      ],  
    );
  }

}

/*
Container(
  margin: EdgeInsets.only(
    top: 20.0,
    left:20.0,
    right: 20.0
  ),
  child: Row(
    children: [
      Text(
        "Mis Vehiculos",
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 26.0,
          fontWeight: FontWeight.w900
        ),
      textAlign: TextAlign.left,
      ),
    ],
  )
),
*/