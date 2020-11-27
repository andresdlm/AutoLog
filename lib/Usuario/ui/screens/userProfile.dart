import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Usuario/model/usuario.dart';
import 'package:autolog/widgets/button_red.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  final User user = FirebaseAuth.instance.currentUser;

  final _controllerNombre = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerPais = TextEditingController();
  final _controllerUid = TextEditingController()..text = FirebaseAuth.instance.currentUser.uid;
  //final _controllerUid = TextEditingController()..text = FirebaseAuth.instance.currentUser.uid;

  Future <void>datosUsuario() async{
    Future<DocumentSnapshot> currentUser = FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
    try {
      await currentUser.then((DocumentSnapshot currentUserSnapshot) => {
        _controllerNombre..text = currentUserSnapshot['name'],
        _controllerEmail..text = currentUserSnapshot['mail'],
        _controllerPhone..text = currentUserSnapshot['phoneNumber'],
        _controllerPais..text = currentUserSnapshot['pais'],  
      });
    } catch (e) {
       return e.message;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of(context);
    datosUsuario();
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "AutoLog",
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 28,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 230.0,
                color: Colors.deepPurple[100],
                child: new Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 10.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Icon(
                              Icons.account_circle, 
                              color: Colors.black,
                              size: 40.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 18.0, top: 8),
                              child: new Text('PROFILE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                      fontFamily: 'sans-serif-light',
                                      color: Colors.black)),
                            ),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0), 
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              //Image.network('https://lh3.googleusercontent.com/a-/AOh14GgWsq8uTma3b4iTyTYFf0gH8MoORNaJ4F8Ny_m9=s96-c'),

                            if(user.photoURL != null)
                              new Container(
                                  width: 140.0,
                                  height: 140.0, 
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                      image: DecorationImage(image: NetworkImage(user.photoURL), fit: BoxFit.cover),
                                  )),
                            if(user.photoURL == null)
                              new Container(
                                  width: 140.0,
                                  height: 140.0, 
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                      image: DecorationImage(image: NetworkImage('https://definicion.de/wp-content/uploads/2019/06/perfildeusuario.jpg'), fit: BoxFit.cover),
                                  )),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 90.0, right: 100.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundColor: Colors.pink[500],
                                  radius: 25.0,
                                  child: new Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                      ]),
                    ),
                  ],
                ),
              ),
              new Container(
                color: Colors.deepPurple[100],
                child: Align(alignment: Alignment.bottomCenter, //BOTON CERRAR
                            child: ButtonRed(text: "Cerrar Sesión", width: 200, height: 50, onPressed: () => {
                              userBloc.singOut()
                              }
                            )
                ),
              ),
              
              new Container(
                color: Colors.deepPurple[100], //color de la lista
                child: Padding(
                  padding: EdgeInsets.only(bottom: 100.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0), //margenes de personal info 
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Información Personal',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? _getEditIcon() : new Container(),
                                ],
                              )
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: _controllerEmail,
                                  decoration: const InputDecoration(
                                      hintText: "Ingrese Email"),
                                  enabled: false,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Nombre',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: _controllerNombre,
                                  decoration: const InputDecoration(
                                    hintText: "Ingrese Nombre",
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,

                                ),
                              ),
                            ],
                          )),
                      /*Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Numero Telf',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: _controllerPhone,
                                  decoration: const InputDecoration(
                                      hintText: "Ingrese Num. Telefono"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),*/
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'Telefono',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  child: new Text(
                                    'País',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                flex: 2,
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: new TextField(
                                    controller: _controllerPhone,
                                    decoration: const InputDecoration(
                                        hintText: "Ingrese num. telf"),
                                    enabled: !_status,
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: new TextField(
                                  controller: _controllerPais,
                                  decoration: const InputDecoration(
                                      hintText: "Ingrese país"),
                                  enabled: !_status,
                                ),
                                flex: 2,
                              ),
                            ],
                          )
                        ), 
                      !_status ? _getActionButtons() : new Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Guardar"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());

                    userBloc.updateUser(Usuario( uid: _controllerUid.text,
                                                 name: _controllerNombre.text,
                                                 email:_controllerEmail.text,
                                                 phoneNumber: _controllerPhone.text, 
                                                 pais: _controllerPais.text,
                                               )
                                        );

                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancelar"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.pink[500],
        radius: 19,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 25.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}