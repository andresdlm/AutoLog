import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Usuario/ui/screens/user_details_screen.dart';
import 'package:autolog/Vehiculo/ui/screens/list-vehiculos.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class Autolog extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _Autolog();
  }

}

class _Autolog extends State<Autolog> {

  int indexTap = 0;
  final List<Widget> widgetsChildren = [
    ListVehiculos(),
    Text("Hola1"),
    BlocProvider<UserBloc>(
      bloc: UserBloc(),
      child: UserDetailsScreen(),
    )
  ];

  void onTapTapped(int index){
    setState(() {
      indexTap = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetsChildren[indexTap],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.indigo
        ),
        child: BottomNavigationBar(
          onTap: onTapTapped,
          currentIndex: indexTap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              title: Text("")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("")
            ),
          ],
        ),
      ),
    );
  }
}