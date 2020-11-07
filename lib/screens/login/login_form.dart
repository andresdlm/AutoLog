import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autolog/screens/register/register_screen.dart';
import 'package:autolog/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:autolog/screens/login/login_form.dart';
import 'package:autolog/widgets/gradient_button.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:autolog/Usuario/model/user.dart';




class LoginForm  extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserBloc userBloc;

 
  

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context){
    userBloc = BlocProvider.of(context);
    return Padding(
      key: _scaffoldKey,
      padding: const EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller:_emailController,
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: "Email"
              ),
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.always,
            ),

            TextFormField(
              controller:_passwordController,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: "Password",
              ),
              obscureText: true,
              autovalidateMode: AutovalidateMode.always,
            ),
            SizedBox(height: 20,
            ),
            GradientButton(
              width: 140,
              height: 45,
              onPressed: () async {
                _signInWithEmailAndPassword().then((FirebaseUser user) {
                    userBloc.updateUserData(User(
                      uid: user.uid,
                      name: user.displayName,
                      email: user.email,
                      photoURL: user.photoUrl
                    ));
                  });
              },
              text: Text('Login', style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                  Icons.check,
                  color: Colors.white
              ),
            ),
            SizedBox(
                height: 10
            ),




            GradientButton(
              width: 140,
              height: 45,
              onPressed: () {
                  userBloc.signIn().then((FirebaseUser user) {
                    userBloc.updateUserData(User(
                      uid: user.uid,
                      name: user.displayName,
                      email: user.email,
                      photoURL: user.photoUrl
                    ));
                  });
                },
              text: Text('Google', style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                  Icons.alternate_email,
                  color: Colors.white
              ),
            ),
            SizedBox(
                height: 10
            ),



            GradientButton(
              width: 140,
              height: 45,
              onPressed: () {
                Navigator.push(context , MaterialPageRoute(builder: (_) {
                  return RegisterScreen();
                }
                ));
              },
              text: Text('Register', style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white
              ),
            ),//Boton register
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<FirebaseUser> _signInWithEmailAndPassword() async {
    try {
      FirebaseUser usuario = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    
      if (!usuario.isEmailVerified) {
        await usuario.sendEmailVerification();
      }
      return usuario;

    }  catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),

      ));
    }

  }

  void _signOut() async {
    await _auth.signOut();
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

}




