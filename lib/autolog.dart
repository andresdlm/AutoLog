import 'package:autolog/Vehiculo/ui/screens/all_mantenimientos.dart';
import 'package:autolog/Vehiculo/ui/screens/list-vehiculos.dart';
import 'package:flutter/material.dart';
import 'package:autolog/Usuario/ui/screens/userProfile.dart';

import 'Usuario/ui/screens/userProfile.dart';

class Autolog extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _Autolog();
  }

}

class _Autolog extends State<Autolog> {

  int _currentIndex = 0;
  final tabs = [
    Center(child: Text("Hola1")),
    Center(child: ListVehiculos()),
    Center(child: ProfilePage(),),
    
    /*Center(child: BlocProvider<UserBloc>(
      bloc: UserBloc(),
      child: UserDetailsScreen(),
    )),*/
    Center(child: AllMantenimientos()),
  ];

  

@override
  Widget build(BuildContext context){
    return Scaffold(
     /* appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Autolog",
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 23,
            fontWeight: FontWeight.bold
          ),
        ),
      ),*/

      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 25,
        selectedFontSize: 13,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('HOME'),
            backgroundColor: Colors.blueAccent,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_rounded),
            title: Text('CARS'),
            backgroundColor: Colors.redAccent,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('PROFILE'),
            backgroundColor: Colors.deepPurpleAccent,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            title: Text('NOTIFICATION'),
            backgroundColor: Colors.teal[400],
          ),
        ],
        onTap: (index) {
          setState((){
            _currentIndex = index;
          });
        },
      ),
    );
  }
}