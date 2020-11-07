import 'package:autolog/Usuario/ui/screens/sign_in_screen.dart';
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
        debugShowCheckedModeBanner: true,
        title: 'AutoLog',
        home: SignInScreen()
      ),
      bloc: UserBloc(),
    );
  }
}
