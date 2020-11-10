import 'package:autolog/Vehiculo/ui/screens/add_mantenimiento.dart';
import 'package:autolog/Vehiculo/ui/widgets/cardMantenimiento.dart';
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

  updateKm(String idVehiculo){
      CollectionReference documentReference = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car');

      Map<String, int> todos={'kilometraje': Km};

      documentReference.doc(idVehiculo).update(todos).whenComplete((){
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
                                return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    title: Text('Actualizar kilometraje'),
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
                          );
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
                padding: EdgeInsets.only(top: 250.0),
                child: Center(
                      child: CircularProgressIndicator()
                ),
            );
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshots.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshots.data.docs[index];
              return CardMantenimiento(documentSnapshot: documentSnapshot, idVehiculo: idVehiculo,);
            },
          );
        },
      ),
    );
  }
}
