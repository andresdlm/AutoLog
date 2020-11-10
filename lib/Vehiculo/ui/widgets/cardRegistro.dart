import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardRegistro extends StatefulWidget {

  final DocumentSnapshot documentSnapshot;
  final VoidCallback onPressed;

  CardRegistro({Key key, @required this.documentSnapshot, this.onPressed});

  @override
  _CardRegistroState createState() => _CardRegistroState(key: this.key, documentSnapshot: this.documentSnapshot, onPressed: this.onPressed);
}

class _CardRegistroState extends State<CardRegistro> {

  final DocumentSnapshot documentSnapshot;
  final VoidCallback onPressed;

  _CardRegistroState({Key key, @required this.documentSnapshot, this.onPressed});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Card(
        elevation: 10,  
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          dense: true,
          leading: Icon(Icons.car_repair),
          title:Text(
            widget.documentSnapshot['fechaRealizado'],
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600
            ),
          ),
          subtitle:Text(
            'Realizado a los: ${documentSnapshot['kilometrajeMantenimiento']} Km\nCosto: ${documentSnapshot['precioServicio']} dolares\nDescripción: ${documentSnapshot['descripcion']}',
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