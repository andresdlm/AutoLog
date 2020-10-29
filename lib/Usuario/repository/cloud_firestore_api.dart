import 'package:autolog/Usuario/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String PLACE = "vehiculos";

  final Firestore _db = Firestore.instance;

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

}