import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Usuario/model/user.dart';
import 'package:autolog/autolog.dart';
import 'package:autolog/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:autolog/screens/login/login_form.dart';
import 'package:autolog/widgets/gradient_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';



class RegisterForm  extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displaynameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSuccess;
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
              controller:_displaynameController,
              decoration: InputDecoration(
                  icon: Icon(Icons.person_add_alt_1),
                  labelText: "Name"
              ),
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.always,
            ),

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

            SizedBox(height: 10,
            ),
            GradientButton(
              width: 140,
              height: 45,
              onPressed: () async {
                _registerAccount().then((FirebaseUser user) {
                    userBloc.updateUserData(User(
                      uid: user.uid,
                      name: _displaynameController.text,
                      email: user.email,
                      photoURL: user.photoUrl
                    ));
                  }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Autolog()));
              });
              },
              text: Text('Register', style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                  Icons.check,
                  color: Colors.white
              ),
            ),
            SizedBox(
                height: 10
            ),
          ],
        ),
      ),
    );
  }

   Future<FirebaseUser> _registerAccount() async {
    try{
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ));

    if (user != null) {
      if (!user.isEmailVerified) {
        await user.sendEmailVerification();
      }
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = _displaynameController.text;
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
