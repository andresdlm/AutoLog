import 'package:firebase_auth/firebase_auth.dart';
import 'package:autolog/Usuario/repository/firebase_auth_api.dart';
import 'package:flutter/material.dart';

class AuthRepository {

  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<String> signInFirebase() => _firebaseAuthAPI.signIn();

  signOut() => _firebaseAuthAPI.signOut();

  Future<String> signInFirebaseEmailPassword(String email, String password) => _firebaseAuthAPI.signInWithEmailAndPassword(email, password);

  Future<void> registerUser(String email, String password, String name) => _firebaseAuthAPI.registerAccount(email, password, name);

}