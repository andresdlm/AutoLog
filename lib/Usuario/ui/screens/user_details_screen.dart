import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/widgets/button_red.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserDetailsScreen();
  }
  
}

class _UserDetailsScreen extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    UserBloc userBloc = BlocProvider.of(context);
    return Scaffold(
      body: ButtonRed(text: "Cerrar Sesion", onPressed: () => {
        userBloc.singOut()
      }, height: 50.0,),
    );
  }
  
}