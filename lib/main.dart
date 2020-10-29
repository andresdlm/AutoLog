import 'package:autolog/autolog_material.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:autolog/Usuario/bloc/bloc_user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
      title: 'AutoLog',
      home: AutologMaterial()
    ),
      bloc: UserBloc(),
    );
  }
}
