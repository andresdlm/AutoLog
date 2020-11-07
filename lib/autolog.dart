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

  int _currentIndex = 0;
  final tabs = [
    Center(child: Text("Hola1")),
    Center(child: ListVehiculos()),
    Center(child: BlocProvider<UserBloc>(
      bloc: UserBloc(),
      child: UserDetailsScreen(),
    )),
    Center(child: Text('notification')),
  ];

  

@override
  Widget build(BuildContext context){
    return Scaffold(

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
            backgroundColor: Colors.deepOrangeAccent,
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