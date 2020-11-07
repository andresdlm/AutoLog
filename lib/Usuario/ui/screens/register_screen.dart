import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Usuario/model/usuario.dart';
import 'package:autolog/widgets/curved_widget.dart';
import 'package:autolog/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class RegisterScreen extends StatelessWidget{

  UserBloc userBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displaynameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  
  @override
  Widget build(BuildContext context){
    userBloc = BlocProvider.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xff6a515e),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfff2cbd0), Color(0xfff4ced9)],
            )),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              CurvedWidget(
                child: Container(
                  padding: const EdgeInsets.only(top: 100, left: 50),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.white.withOpacity(0.4)], //opacidad del rojo
                    ),
                  ),
                  child: Text('Register', style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff6a515e),
                  ),),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 230), //margen top de text email
                child: Padding(
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
                            userBloc.registerUser(this._emailController.text, this._passwordController.text, this._displaynameController.text).whenComplete(() {
                              userBloc.updateUserData();
                            }).whenComplete(() {
                              Navigator.pop(context);
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
                        GradientButton(
                          width: 140,
                          height: 45,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: Text('Log In', style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(
                            Icons.login_rounded
                          ),
                        ),
                        SizedBox(
                            height: 10
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



}