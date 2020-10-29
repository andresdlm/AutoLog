import 'package:autolog/Vehiculo/ui/screens/list-vehiculos.dart';
import 'package:flutter/material.dart';

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
    Text("Hola2")
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