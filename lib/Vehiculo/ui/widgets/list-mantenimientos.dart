import 'package:autolog/Vehiculo/ui/screens/add_mantenimiento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListMantenimientos extends StatelessWidget {
  final String idVehiculo;
  User user;
  int Km;

  ListMantenimientos({Key key, this.idVehiculo}): super(key: key){
    user = FirebaseAuth.instance.currentUser;
  }

  int kilometraje;
  int kilometrajeAnterior;
  int frecuencia;
  int ultimoServicio;

   Future <bool> notificaciones() async{
     bool notificar;
     Future<DocumentSnapshot> car = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).get();
      await car.then((DocumentSnapshot carSnapshot) => {
        print('Kilometraje: ${carSnapshot['kilometraje']}'),
        print('Km Anterior: ${carSnapshot['kilometrajeAnterior']}'),
        kilometraje = carSnapshot['kilometraje'],
        kilometrajeAnterior = carSnapshot['kilometrajeAnterior'],
        print('ESTE ES EL KILOMETRAJEE: ${kilometraje}'),
        print('ESTE ES EL KILOMETRAJEE ANTERIOR: ${kilometrajeAnterior}'),
      });

      Future<DocumentSnapshot> notificacion = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection('Mantenimientos').doc('nvq5nkMe3Fd403XaTCgk').get();
      await notificacion.then((DocumentSnapshot notificacionSnapshot)=>{
        print("frecuencia de matenimiento: ${notificacionSnapshot['frecuenciaMantenimiento']}"),
        print("ultimo servicio: ${notificacionSnapshot['ultimoServicio']}"),
        frecuencia = notificacionSnapshot['frecuenciaMantenimiento'],
        ultimoServicio = notificacionSnapshot['ultimoServicio'],
        print('ESTA ES LA FRECUENCIA MANTENIMIENTO: ${frecuencia}'),
        print('ESTE ES EL ULTIMO SERVICIO: ${ultimoServicio}'),
      });

      await FirebaseFirestore.instance
      .collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection('Mantenimientos')
      .get()
      .then((QuerySnapshot querySnapshot) =>{
        querySnapshot.docs.forEach((doc){
          print(doc['tipoMantenimiento']);
        }),
      });
      
      if(kilometraje-ultimoServicio >= frecuencia){
        print("ENTRE EN EL IF");
        notificar = true;
        return true;
      }
      else{
        print("ENTRE EN EL ELSE");
        notificar = false;
        return false;
      }
      /*if(kilometraje-kilometrajeAnterior >= frecuencia){
        print("Entre aqui");
        notificar=true;
        return notificar;
      }
      else{
        print("Estoy entrando aqui no se por que");
        notificar = false;
        return notificar;
      }*/
  }

  deleteMantenimiento(item){
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users');

    documentReference.doc(user.uid).collection('Car').doc(idVehiculo).collection('Mantenimientos').doc(item).delete().whenComplete((){
      print('$item deleted');
      print('Id del Vehiculo: $idVehiculo');
      print('El user Uid es: $user.uid');
    });

  }

  updateKm(String idVehiculo){
      CollectionReference documentReference = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car');

      Map<String, int> kilometraje={'kilometraje': Km};

      documentReference.doc(idVehiculo).update(kilometraje).whenComplete((){
        print('$Km, Actualizado');
        print(idVehiculo);
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: Container(
          height: 150,
          width: 150,
          child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                      child: Icon(
                          Icons.edit_road,
                          size: 40
                      ),
                      onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return  AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        contentPadding: EdgeInsets.all(30.0),
                                        title: Text('Actualizar kilometraje'),
                                        elevation: 5.0,
                                        backgroundColor: Colors.blue[50],
                                        content: new Column(
                                          children: [
                                            new Expanded(
                                                child: new TextField(
                                                  decoration: new InputDecoration(
                                                      icon: Icon(Icons.update_rounded),
                                                      labelText: 'Km', hintText: '10000'),
                                                  onChanged: (String value) {
                                                    Km = int.parse(value);
                                                  },
                                                )),
                                          ],
                                        ),
                                        actions: <Widget>[
                                            FlatButton(
                                                onPressed:(){
                                                    updateKm(idVehiculo);
                                                    Navigator.of(context).pop();
                                                },
                                                child:Text('add'))
                                        ],
                                ); 
                               
                                
                              }
                          ).whenComplete((){
                            notificaciones().then((conectionResult){
                              if(conectionResult == true){
                                 showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: new Text('Tienes mantenimiento pendiente'),
                                        actions: <Widget>[
                                        ],
                                      );
                                    },
                                );
                              }
                            });
                          });
                         /* whenComplete((){
                              if( notificaciones()){
                                print("Entre porque RETORNE True");
                              }
                              else{
                                print("Entre porque RETORNE False");
                              }
                          });*/
                      },
                      heroTag: null,
                      
                  ),
                  SizedBox(
                        height: 100,
                        width: 10,
                  ),
                  FloatingActionButton(           
                        child: Icon(
                            Icons.add_alert,
                            size: 30
                        ),
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddMantenimientoScreen(idVehiculo: idVehiculo,)));
                        },
                      heroTag: null,
                  )
                ]
              ),
          ),
          
      ),

      
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection("Mantenimientos").snapshots(),
        builder: (context, snapshots) {
          if(snapshots.data == null)
          return Container( 
                padding: EdgeInsets.only(bottom: 150.0),
                child: Center(
                    child: CircularProgressIndicator()
                ),
            );
          switch(snapshots.connectionState){
            case ConnectionState.active:
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot = snapshots.data.docs[index];
                    return InkWell(
                      key: Key(documentSnapshot['tipoMantenimiento']),
                      child: Card(
                        elevation: 10,  
                        margin: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        color: Colors.blue[100],
                        child: ListTile(
                          dense: true,
                          leading: Icon(Icons.access_alarm, size:40),
                          title:Text(
                            documentSnapshot['tipoMantenimiento'],
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          subtitle:Text(
                            'Se realiza cada: ${documentSnapshot['frecuenciaMantenimiento']} Km\nUltimo servicio: ${documentSnapshot['ultimoServicio']} Km',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w200
                            ),
                          ),
                          
                          trailing: Wrap(
                            spacing: -5,
                            children: <Widget>[
                              /*IconButton(
                                padding: const EdgeInsets.only(top: 0),
                                icon: Icon(
                                  Icons.settings,
                                  size: 35,
                                  color: Colors.blue,
                                ),
                                onPressed: () {

                                },
                              ),*/
                              IconButton(
                                padding: const EdgeInsets.only(top: 0),
                                icon: Icon(
                                  Icons.notifications_off,
                                  size: 35,
                                  color: Colors.red,
                                ),
                                onPressed: (){
                                  deleteMantenimiento(documentSnapshot.id);
                                }
                              ),
                            ],
                          ),
                        )
                      )
                    );
                  },
              );
            default: return Text("Loading data");

          }
        },
      ),
    );
  }
}
