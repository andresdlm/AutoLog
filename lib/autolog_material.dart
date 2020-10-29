import 'package:autolog/Vehiculo/ui/screens/list-vehiculos.dart';
import 'package:autolog/Vehiculo/ui/widgets/bannerVehiculo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:generic_bloc_provider/generic_bloc_provider.dart';


class AutologMaterial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.traffic, color: Colors.indigo),
              title: Text("Mis vehiculos")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build, color: Colors.indigo),
              title: Text("Mantenimientos")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.indigo),
              title: Text("Mi cuenta")
            ),
          ],
        ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
                builder: (BuildContext context) {
                  return new ListVehiculos();
                },
              );
            break;
            case 1:
            return CupertinoTabView(
                builder: (BuildContext context) {
                  return Text("Hola2");
                },
              );
            break;
            case 2:
            return CupertinoTabView(
                builder: (BuildContext context) {
                  return Text("Hola4");
                },
              );
            break;
        }
        
      }

      ),

    );
  }

}