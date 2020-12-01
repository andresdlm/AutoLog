import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class vehiculoDetails extends StatelessWidget {
  final String idVehiculo; 
  vehiculoDetails({Key key, this.idVehiculo}): super(key: key);
  final User user = FirebaseAuth.instance.currentUser;


 traerDatos(){
   CollectionReference documentReference = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car');
      DocumentReference Hola = documentReference.doc(idVehiculo);
      print(Hola.get());

      Future<DocumentSnapshot> car = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).get();
      car.then((DocumentSnapshot carSnapshot) => {
        print(carSnapshot['marca']),
        print(carSnapshot['modelo']),
        print(carSnapshot['color']),
        print(carSnapshot['year']),
        print(carSnapshot['km']),

      });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(idVehiculo)),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('')),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'holi',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: (){traerDatos();},
            ),
          ],
        ),
      ),
    );
  }
}