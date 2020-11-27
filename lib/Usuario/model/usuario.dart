import 'package:flutter/material.dart';

class Usuario {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final String phoneNumber;
  final String pais; 

  Usuario({
    Key key,
    this.uid,
    this.name,
    this.email,
    this.photoURL,
    this.phoneNumber, 
    this.pais, 
  });

}