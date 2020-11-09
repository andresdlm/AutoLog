import 'package:autolog/Vehiculo/ui/screens/add_mantenimiento.dart';
import 'package:autolog/Vehiculo/ui/widgets/cardMantenimiento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListMantenimientos extends StatelessWidget {
  final String idVehiculo;
  User user;

  ListMantenimientos({Key key, this.idVehiculo}): super(key: key){
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: Container(
          height: 100.0,
          width: 100.0,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: FloatingActionButton(
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddMantenimientoScreen(idVehiculo: idVehiculo,)));
              },
              child: Icon(Icons.add, size: 40),
              backgroundColor: Color(0xFF2196F3),
              elevation: 10.0,
              ) 
          ),
      ),
          
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection("Mantenimientos").snapshots(),
        builder: (context, snapshots) {
          if(snapshots.data == null) return CircularProgressIndicator();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshots.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshots.data.docs[index];
              return CardMantenimiento(documentSnapshot: documentSnapshot);
            },
          );
        },
      ),
    );
  }
}
