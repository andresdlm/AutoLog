import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardMantenimiento extends StatefulWidget {

  final DocumentSnapshot documentSnapshot;
  final VoidCallback onPressed;

  CardMantenimiento({Key key, @required this.documentSnapshot, this.onPressed});

  @override
  _CardMantenimientoState createState() => _CardMantenimientoState(key: this.key, documentSnapshot: this.documentSnapshot, onPressed: this.onPressed);
}

class _CardMantenimientoState extends State<CardMantenimiento> {

  final DocumentSnapshot documentSnapshot;
  final VoidCallback onPressed;

  _CardMantenimientoState({Key key, @required this.documentSnapshot, this.onPressed});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      key: Key(documentSnapshot['tipoMantenimiento']),
      child: Card(
        elevation: 10,  
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          dense: true,
          leading: Icon(Icons.car_repair),
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
              IconButton(
                padding: const EdgeInsets.only(top: 0),
                icon: Icon(
                  Icons.settings,
                  size: 35,
                  color: Colors.blue,
                ),
                onPressed: () {

                },
              ),
              IconButton(
                padding: const EdgeInsets.only(top: 0),
                icon: Icon(
                  Icons.delete,
                  size: 35,
                  color: Colors.red,
                ),
                onPressed: (){
                  
                }
              ),
            ],
          ),
        )
      )
    );
  }
}