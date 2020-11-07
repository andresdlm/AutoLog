import 'package:autolog/Usuario/model/usuario.dart';
import 'package:autolog/Usuario/repository/cloud_firestore_api.dart';
import 'package:autolog/Usuario/repository/cloud_firestore_repository.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/Vehiculo/ui/widgets/bannerVehiculo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:autolog/Usuario/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class UserBloc implements Bloc {

  // ignore: non_constant_identifier_names
  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;

  // Casos de uso
  //1. SignIn por Google
  Future<String> signIn() {
    return _auth_repository.signInFirebase();
  }

  //2. SignOut
  singOut() {
    _auth_repository.signOut();
  }

  //3. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData() => _cloudFirestoreRepository.updateUserDataFirestore();

  //4. Ingresar un nuevo vehiculo
  Future<void> createVehiculo(Vehiculo vehiculo) => _cloudFirestoreRepository.createVehiculo(vehiculo);

  //5. Leer los vehiculos
  Stream<QuerySnapshot> vehiculosListStream = FirebaseFirestore.instance.collection(CloudFirestoreAPI().VEHICULOS).snapshots();
  Stream<QuerySnapshot> get vehiculosStream => vehiculosListStream;
  //List<BannerVehiculo> buildVehiculos(List<DocumentSnapshot> vehiculosListSnapshot) => _cloudFirestoreRepository.buildVehiculos(vehiculosListSnapshot);

  // 6. Iniciar sesion con correo y contraseña
  Future<String> signInEmailPassword(String email, String password) {
    return _auth_repository.signInFirebaseEmailPassword(email, password);
  }

  // 7. Registrar usuario
  Future<void> registerUser(String email, String password, String name) {
    return _auth_repository.registerUser(email, password, name);
  }

  @override
  void dispose() {

  }
}