import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String VEHICULOS = "vehiculos";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection('Users');


  Future<void> updateUserData() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    String name = auth.currentUser.displayName.toString();
    String mail = auth.currentUser.email.toString();
    String phoneNumber = auth.currentUser.phoneNumber.toString();
    String photoURL = auth.currentUser.photoURL.toString();

    return users.doc(uid).set({
      'uid': uid,
      'name':name,
      'mail': mail,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,

    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> createVehiculo(Vehiculo vehiculo){
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users');

    documentReference.doc(user.uid).collection('Car').doc().set({
      'marca': vehiculo.marca,
      'modelo': vehiculo.modelo,
      'year': vehiculo.year,
      'color': vehiculo.color,
      'km': vehiculo.kilometraje,
      'owner': user.uid,

    }).whenComplete((){
      print('$vehiculo.marca, $vehiculo.modelo created');
    });

    return null;
  }

  

}