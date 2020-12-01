import 'package:autolog/widgets/title_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AllMantenimientos extends StatefulWidget {

  State<StatefulWidget> createState() {
    return AllMantenimientosState();
  }
}
  
  class AllMantenimientosState extends State<AllMantenimientos> {

  User user;
  List <Stream<QuerySnapshot>> listaSnapshots =[];

  AllMantenimientosState({Key key}){
    user = FirebaseAuth.instance.currentUser;
  }


  colorPorPrioridad(String prioridad) {
      
        if(prioridad == 'BAJA') 
          return Colors.green[100];
        else if(prioridad  == 'MEDIA') 
          return Colors.orange[100];
        else if(prioridad  == 'ALTA') 
          return Colors.red[100];
        else{
          return Colors.blue[100];
        }

  }

  updateEstadoNotificacion(String idVehiculo, String idMantenimiento, bool estadonotificacion){
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users').doc(user.uid).
                                                                       collection('Car').doc(idVehiculo).
                                                                       collection('Mantenimientos');
      if(estadonotificacion == true){
         Map<String, bool> mapEstadoNoti={'estadoNotificacion': false};
         documentReference.doc(idMantenimiento).update(mapEstadoNoti);
        
      }else if (estadonotificacion == false){
        Map<String, bool> mapEstadoNoti={'estadoNotificacion': true};
        documentReference.doc(idMantenimiento).update(mapEstadoNoti);
      }
  }

  seleccionarIcono2(bool estadoNotificacion){
    if(estadoNotificacion == true)
      return Icons.access_alarm;
    else
      return Icons.alarm_off;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      /*floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: FloatingActionButton(
            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => AddRegistroScreen(idVehiculo: idVehiculo,)));
            },
          child: Icon(Icons.add, size: 40),
          backgroundColor: Color(0xFF2196F3),
          elevation: 10.0,
          ) 
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,*/

      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text(
          "AutoLog",
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 28,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    
      body: SingleChildScrollView(
        child: Container(
          color: Colors.teal[50],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: TitleHeader(title: "Mis Notificaciones", fontSize: 30,),
                margin: EdgeInsets.only(left: 10, top: 30, bottom: 10), 
              ),

              StreamBuilder <QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').snapshots(),
                builder: (context,  snapshots) {
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
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshots.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot = snapshots.data.docs[index];
                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(documentSnapshot.id).collection('Mantenimientos').snapshots(),
                              builder: (context,  snapshots) {
                                  if(snapshots.data == null)
                                    return Container( 
                                          padding: EdgeInsets.only(bottom: 150.0),
                                          child: Center(
                                              child: CircularProgressIndicator()
                                          ),
                                    );       
                                  return  ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 20.0, left: 20.0, top: 5.0, bottom: 5.0),
                                          child: Center(
                                            child: new Text('${documentSnapshot['marca']} ${documentSnapshot['modelo']}', 
                                                        style: TextStyle(height: 1.5,
                                                                         fontSize: 27.0,
                                                                         fontFamily: "Lato",
                                                                         color: Colors.teal[800],
                                                                         fontWeight: FontWeight.w700)
                                                      ),
                                          ),
                                        ),
                                        color: Colors.teal[50],
                                      ), 

                                            ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: snapshots.data.docs.length,
                                              itemBuilder: (context, index) {
                                                DocumentSnapshot documentSnapshot = snapshots.data.docs[index];
                                                var card = Card(
                                                  elevation: 5,  
                                                  margin: EdgeInsets.all(8),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                  color: colorPorPrioridad(documentSnapshot['prioridad']),
                                                  child: ListTile(
                                                    dense: true,
                                                    trailing: Builder(
                                                      builder:(BuildContext context){
                                                        return IconButton(
                                                          padding: const EdgeInsets.only(bottom: 3.0, right: 15),
                                                          icon: Icon(seleccionarIcono2(documentSnapshot['estadoNotificacion']),size: 40,),
                                                          onPressed: (){
                                                            updateEstadoNotificacion(documentSnapshot['idVehiculo'], documentSnapshot.id, documentSnapshot['estadoNotificacion']); 
                                                          },
                                                        );
                                                      },
                                                    ),      
                                                    title: Padding(
                                                      padding: const EdgeInsets.only(left: 15.0),
                                                      child: Text('Notificación:   ${documentSnapshot['tipoMantenimiento']}',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily: 'Lato',
                                                          fontWeight: FontWeight.w600
                                                        ),
                                                      ),
                                                    ),
                                                   
                                                    subtitle: Padding(
                                                      padding: const EdgeInsets.only(left: 15.0),
                                                      child: Text('Se realiza cada: ${documentSnapshot['frecuenciaMantenimiento']} Km\nUltimo servicio: ${documentSnapshot['ultimoServicio']} Km\nDescripción: ${documentSnapshot['descripcion']}',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Lato',
                                                          fontWeight: FontWeight.w300
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                                return InkWell(
                                                  key: Key(documentSnapshot['tipoMantenimiento']),
                                                  child: card
                                                );
                                              },
                                            ),
                                    ],
                                  );
                              });
                          },
                      );
                    default: return Text("Loading data");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ); //scaffol
  } 
}

  


