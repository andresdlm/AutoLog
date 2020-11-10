import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CardMantenimiento extends StatefulWidget {

  final DocumentSnapshot documentSnapshot;
  final VoidCallback onPressed;
  final String idVehiculo;

  CardMantenimiento({Key key, @required this.documentSnapshot, this.onPressed, this.idVehiculo});

  @override
  _CardMantenimientoState createState() => _CardMantenimientoState(key: this.key, documentSnapshot: this.documentSnapshot, onPressed: this.onPressed);
}

class _CardMantenimientoState extends State<CardMantenimiento> {

  final DocumentSnapshot documentSnapshot;
  final VoidCallback onPressed;
  final String idVehiculo;

  _CardMantenimientoState({Key key, @required this.documentSnapshot, this.onPressed, this.idVehiculo});
  
   deleteVehiculo(item){
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users');

    documentReference.doc(user.uid).collection('Car').doc(idVehiculo).collection('Mantenimientos').doc(item).delete().whenComplete((){
      print('$item deleted');
    });

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      key: Key(documentSnapshot['tipoMantenimiento']),
      child: Card(
        elevation: 10,  
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.blue[100],
        child: ListTile(
          dense: true,
          leading: Icon(Icons.access_alarm, size:40),
          title:Text(
            widget.documentSnapshot['tipoMantenimiento'],
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600
            ),
          ),
          subtitle:Text(
            'Se realiza cada: ${documentSnapshot['frecuenciaMantenimiento']} Km\nUltimo servicio: ${documentSnapshot['ultimoServicio']} Km',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w200
            ),
          ),
          
          trailing: Wrap(
            spacing: -5,
            children: <Widget>[
              /*IconButton(
                padding: const EdgeInsets.only(top: 0),
                icon: Icon(
                  Icons.settings,
                  size: 35,
                  color: Colors.blue,
                ),
                onPressed: () {

                },
              ),*/
              IconButton(
                padding: const EdgeInsets.only(top: 0),
                icon: Icon(
                  Icons.notifications_off,
                  size: 35,
                  color: Colors.red,
                ),
                onPressed: (){
                  deleteVehiculo(documentSnapshot.id);
                }
              ),
            ],
          ),
        )
      )
    );
  }
}