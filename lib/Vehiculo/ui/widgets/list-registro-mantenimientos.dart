import 'package:autolog/Vehiculo/ui/screens/add_registro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListRegistroMantenimientos extends StatelessWidget {

  final String idVehiculo;
  final String idMantenimiento;
  User user;

  ListRegistroMantenimientos({Key key, this.idVehiculo, this.idMantenimiento}): super(key: key){
    user = FirebaseAuth.instance.currentUser;
    Stream snapshot = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection("Registro").snapshots();
  }


  deleteRegistro(item){
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users');

    documentReference.doc(user.uid).collection('Car').doc(idVehiculo).collection('Registro').doc(item).delete().whenComplete((){
      print('$item deleted');
      print('Id del Vehiculo: $idVehiculo');
      print('El user Uid es: $user.uid');
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold( 


      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddRegistroScreen(idVehiculo: idVehiculo,)));
            },
          child: Icon(Icons.add, size: 40),
          backgroundColor: Color(0xFF2196F3),
          elevation: 10.0,
          ) 
        ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection("Registro").snapshots(),
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
                          color: Colors.blue[100], //color de la tarjeta
                          child: ListTile(
                            dense: true,
                            leading: Builder(
                            builder:(BuildContext context){
                              return IconButton(
                                padding: const EdgeInsets.only(top: 15.0),
                                icon: Icon(Icons.plumbing, size:40.0),
                                onPressed: (){},
                              );
                            },
                          ),
                            title:Text(
                              '${documentSnapshot['fechaRealizado']}\n ${documentSnapshot['tipoMantenimiento']}',
                              style: TextStyle(
                                fontSize: 19,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            subtitle:Text(
                              'Realizado a los: ${documentSnapshot['kilometrajeMantenimiento']} Km\nCosto: ${documentSnapshot['precioServicio']} dolares\nDescripción: ${documentSnapshot['descripcion']}',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            
                            trailing: Wrap(
                              spacing: -5,
                              children: <Widget>[
                              /* IconButton(
                                  padding: const EdgeInsets.only(top: 0),
                                  icon: Icon(
                                    Icons.settings,
                                    size: 35,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {

                                  },
                                ), */
                                IconButton(
                                  padding: const EdgeInsets.only(top: 15),
                                  icon: Icon(
                                    Icons.delete,
                                    size: 35,
                                    color: Colors.red,
                                  ),
                                  onPressed: (){
                                    deleteRegistro(documentSnapshot.id);
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
  


