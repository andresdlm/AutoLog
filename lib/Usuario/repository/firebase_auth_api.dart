import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class FirebaseAuthAPI {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signIn() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    final UserCredential userCredential =
    await _auth.signInWithCredential(authCredential);
    final User user = userCredential.user;
    assert(user.displayName != null);
    assert(user.email != null);
    assert(user.photoURL != null);

    final User currentUser = _auth.currentUser;
    assert(currentUser.uid == user.uid);

    return 'Logged In';
  }

  void signOut() async {
    await _auth.signOut().then((value) => print("Sesion Cerrada"));
    googleSignIn.signOut();
  }

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> registerAccount(String email, String password, String name) async {
    try {
        final User user = (await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        )).user;

        if (user != null) {
          if (!user.emailVerified) {
            await user.sendEmailVerification();
          }
          await user.updateProfile(displayName: name);

        } else {
          print("Registro fallido");
        }
    } catch (e) {
    }
    
  }
  


}