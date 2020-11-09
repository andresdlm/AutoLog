import 'package:autolog/Vehiculo/ui/screens/add_mantenimiento.dart';
import 'package:autolog/Vehiculo/ui/widgets/cardMantenimiento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListMantenimientos extends StatelessWidget {

  String idVehiculo;  
  final User user = FirebaseAuth.instance.currentUser;


  ListMantenimientos({Key key, this.idVehiculo}): super(key: key) {
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car');
    Future<DocumentSnapshot> vehiculo = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).get();
    vehiculo.then((DocumentSnapshot carSnapshot) => {
      
    });
  }

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddMantenimientoScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF2196F3),
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