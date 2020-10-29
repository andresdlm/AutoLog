import 'package:autolog/Usuario/model/user.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String PLACES = "vehiculos";

  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  void updateUserData(User user) async {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return ref.setData({
      'id': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'misVehiculos': user.misVehiculos,
      'lastSignIn': DateTime.now()
    }, merge: true);
  }

  Future<void> updatePlaceDate(Vehiculo vehiculo) async {
    CollectionReference refVehiculos = _db.collection(PLACES);
    String uid = (await _auth.currentUser()).uid;
    
    
    await _auth.currentUser().then((FirebaseUser) {

      refVehiculos.add({
        'marca': vehiculo.marca,
        'modelo': vehiculo.modelo,
        'year': vehiculo.year,
        'color': vehiculo.color,
        'kilometraje': vehiculo.kilometraje,
        'userOwner': "$USERS/$uid",
      });

    });

  }

}