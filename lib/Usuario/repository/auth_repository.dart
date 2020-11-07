import 'package:firebase_auth/firebase_auth.dart';
import 'package:autolog/Usuario/repository/firebase_auth_api.dart';
import 'package:flutter/material.dart';

class AuthRepository {

  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> signInFirebase() => _firebaseAuthAPI.signIn();

  signOut() => _firebaseAuthAPI.signOut();

  Future<FirebaseUser> signInFirebaseEmailPassword(String email, String password, BuildContext context) => _firebaseAuthAPI.signInWithEmailAndPassword(email, password, context);

  Future<FirebaseUser> registerUser(String email, String password, BuildContext context) => _firebaseAuthAPI.registerAccount(email, password, context);

}