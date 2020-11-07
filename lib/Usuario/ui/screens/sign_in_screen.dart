import 'package:autolog/Usuario/model/usuario.dart';
import 'package:autolog/autolog.dart';
import 'package:autolog/Usuario/ui/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:autolog/widgets/curved_widget.dart';
import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:autolog/widgets/gradient_button.dart';


class SignInScreen extends StatefulWidget {

  @override
  State createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //snapshot- data - Object User
        if(!snapshot.hasData || snapshot.hasError) {
          return loginScreen();
        } else {
          return Autolog();
        }
      },
    );
  }

  Widget loginScreen() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                  child: Text('Login', style: TextStyle(
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
                            userBloc.signInEmailPassword(_emailController.text, _passwordController.text).whenComplete(() {
                              _emailController.clear();
                              _passwordController.clear();
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
                            userBloc.signIn().whenComplete(() {
                              userBloc.updateUserData();
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterScreen())
                            );
                          },
                          text: Text('Register', style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white
                          ),
                        ),//Bot
                        
                      ],
                    ),
                  ),
                )
              )
            ],
          ),
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



}