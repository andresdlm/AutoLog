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

  int _currentIndex = 1;
  final tabs = [
    //Center(child: Text("Home")),
    Center(child: AllMantenimientos()),
    Center(child: ListVehiculos()),
    Center(child: ProfilePage(),),
  ];

@override
  Widget build(BuildContext context){
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Colors.grey[900],
        type: BottomNavigationBarType.shifting,
        iconSize: 30,
        selectedFontSize: 14,
        items: [
          /*BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('HOME'),
            backgroundColor: Colors.blueAccent,
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            title: Text('NOTIFICATION'),
            backgroundColor: Colors.teal[400],
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