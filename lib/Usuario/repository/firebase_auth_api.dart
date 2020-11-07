import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class FirebaseAuthAPI {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithCredential(
      GoogleAuthProvider.getCredential(idToken: gSA.idToken, accessToken: gSA.accessToken)
    );

    return user;
  }

  void signOut() async {
    await _auth.signOut().then((value) => print("Sesion Cerrada"));
    googleSignIn.signOut();
  }

  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      FirebaseUser usuario = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ));
    
      if (!usuario.isEmailVerified) {
        await usuario.sendEmailVerification();
      }
      print("+++++++++++++++++++++++++++++++++++");
      print(usuario);
      print("+++++++++++++++++++++++++++++++++++");
      return usuario;

    }  catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),
      ));
    }
  }

  Future<FirebaseUser> registerAccount(String email, String password, BuildContext context) async {
    try{
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ));

      if (user != null) {
        if (!user.isEmailVerified) {
          await user.sendEmailVerification();
        }
        UserUpdateInfo info = UserUpdateInfo();
        user.updateProfile(info);
        print("+++++++++++++++++++++++++++++++++++");
        print(user.displayName);
        print("+++++++++++++++++++++++++++++++++++");
        return user;
      } 

    }catch(e){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to register with Email & Password"),
      ));

    }
  }


}