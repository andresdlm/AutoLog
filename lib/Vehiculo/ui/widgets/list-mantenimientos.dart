import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/model/registro.dart';
import 'package:autolog/Vehiculo/ui/screens/add_mantenimiento.dart';
import 'package:autolog/Vehiculo/ui/screens/update_mantenimientos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class ListMantenimientos extends StatelessWidget {
  final String idVehiculo;
  User user;
  int controllerKm;
  int controllerPrecio;
  String controllerDescripcion ="";

  ListMantenimientos({Key key, this.idVehiculo}): super(key: key){
    user = FirebaseAuth.instance.currentUser;
    //user.updateEmail(newEmail)
  }

  int kilometraje;
  int frecuencia;
  int ultimoServicio;
  List<Map> lista = [];

   Future <bool> notificaciones() async{
     bool notificar = false;
     Future<DocumentSnapshot> car = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).get();
      await car.then((DocumentSnapshot carSnapshot) => {
        //print('Kilometraje: ${carSnapshot['kilometraje']}'),
        kilometraje = carSnapshot['kilometraje'],
      });

      await FirebaseFirestore.instance
      .collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection('Mantenimientos')
      .get()
      .then((QuerySnapshot querySnapshot) =>{
        querySnapshot.docs.forEach((doc){
          String prioridad = updateprioridad(doc.id, doc['ultimoServicio'], kilometraje, doc['frecuenciaMantenimiento']);

          if (kilometraje-doc['ultimoServicio'] >= doc['frecuenciaMantenimiento'] && doc['estadoNotificacion'] == true){
            
            Map<String, dynamic> map ={'tipoMantenimiento': doc['tipoMantenimiento'], 
              'frecuenciaMantenimiento': doc['frecuenciaMantenimiento'],
              'descripcion': doc['descripcion'],
              'ultimoServicio': doc['ultimoServicio'],
              'prioridad': prioridad, 
            };    
            lista.add(map);
            notificar = true;
          }
        }),
      });
      return notificar;
    
  }

  updateprioridad(String idMantenimiento, int ultimoServicio, int kilimetraje, int frecuencia){
    String prioridad ="";

    if(kilometraje-ultimoServicio >= frecuencia){
        if(kilometraje-ultimoServicio >= frecuencia && kilometraje-ultimoServicio <= frecuencia +1000)
          prioridad = "BAJA";
        else if(kilometraje-ultimoServicio > frecuencia + 1000 && kilometraje-ultimoServicio <= frecuencia + 3000)
          prioridad = "MEDIA";
        else if(kilometraje-ultimoServicio > frecuencia + 3000)
          prioridad = "ALTA";
    };

    Map<String, dynamic> mapPrioridad ={'prioridad': prioridad };

    FirebaseFirestore.instance.collection('Users').doc(user.uid).
                                      collection('Car').doc(idVehiculo)
                                      .collection('Mantenimientos').doc(idMantenimiento).update(mapPrioridad).whenComplete((){
    print('$prioridad, Actualizado');
    });  

    return prioridad; 
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

  updateKm(String idVehiculo, int km){
      CollectionReference documentReference = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car');

      Map<String, int> kilometraje={'kilometraje': km};

      documentReference.doc(idVehiculo).update(kilometraje).whenComplete((){
        print('El vehiculo: $idVehiculo');
        print('Km actualizado a: $km');
      });
  }

  Future <void> updateUltimoServicio(String idVehiculo, String idMantenimiento) async{
    int kilometraje;
    print('ID VEHICULO: $idVehiculo');
    print('ID MANTENIMIETNO: $idMantenimiento');
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users').doc(user.uid).
                                                                       collection('Car').doc(idVehiculo).
                                                                       collection('Mantenimientos');

    Future<DocumentSnapshot> car = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).get();
      await car.then((DocumentSnapshot carSnapshot) => {
        kilometraje = carSnapshot['kilometraje'],
        print('KILOMETRAJE $kilometraje'),
      });
      print('KILOMETRAJE $kilometraje');
    Map<String, dynamic> mapMantenimiento={'ultimoServicio': kilometraje, 'prioridad': ''};
    print(mapMantenimiento);

    documentReference.doc(idMantenimiento).update(mapMantenimiento).whenComplete((){
        print('Actualizado');
        print(idVehiculo);
      });                                                          

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

  seleccionarIcono(String prioridad){
    if(prioridad == 'BAJA' || prioridad == 'MEDIA' || prioridad == 'ALTA')
      return Icons.toggle_on;
    else
      return Icons.edit_attributes;
  }

  seleccionarIcono2(bool estadoNotificacion, String iconColor){
    if(estadoNotificacion == true)
      if(iconColor == "icono")
        return Icons.toggle_on;
      else
        return Colors.blue;
    else
      if(iconColor == "icono")
        return Icons.toggle_off;
      else
        return Colors.blueGrey;
  }

  @override
  Widget build(BuildContext context) { 
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      floatingActionButton: Container(
          height: 150,
          width: 150,
          child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                      backgroundColor: HexColor('#174D80'),
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
                                        contentPadding: EdgeInsets.all(5.0), //padding de la cajita
                                        title: Text('Actualizar kilometraje'),
                                        elevation: 5.0,
                                        backgroundColor: Colors.blue[50],
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                                new TextField(
                                                  decoration: new InputDecoration(
                                                      icon: Icon(Icons.update_rounded),
                                                      labelText: 'Km', hintText: '10000'),
                                                  onChanged: (String value) {
                                                    controllerKm = int.parse(value);  
                                                  },
                                                ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                            FlatButton(
                                                onPressed:(){
                                                  print(controllerKm);
                                                  if(controllerKm != null){
                                                    print("ENTREEEEEE");
                                                    updateKm(idVehiculo, controllerKm); 
                                                    controllerKm = null; 
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child:Text('add', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)))
                                        ],
                                );
                              },
                          ).whenComplete((){
                              notificaciones().then((conectionResult){
                                if(conectionResult == true){
                                    showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.blue[50],
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              title: new Text("ALERTA!\nMantenimientos Pentiendes\nkilometraje ${kilometraje} km\n",
                                                                textAlign: TextAlign.center,
                                                                //overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(color: Colors.red[500], fontWeight: FontWeight.bold, fontSize: 20.0)),
                                              
                                              content: SingleChildScrollView(
                                                child: Column( 
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: List.generate(lista.length, (index){
                                                    return ListBody(
                                                      children: <Widget>[
                                                        if(lista[index]['prioridad'] == 'BAJA') 
                                                          Text('Prioridad: BAJA\n', textAlign: TextAlign.center, style: TextStyle(color: Colors.green[500], fontSize: 18.0, fontWeight: FontWeight.bold)),
                                                        if(lista[index]['prioridad'] == 'MEDIA') 
                                                          Text('Prioridad: MEDIA\n', textAlign: TextAlign.center, style: TextStyle(color: Colors.yellow[900], fontSize: 18.0, fontWeight: FontWeight.bold)),
                                                        if(lista[index]['prioridad'] == 'ALTA') 
                                                          Text('Prioridad: ALTA\n', textAlign: TextAlign.center, style: TextStyle(color: Colors.red[500], fontWeight: FontWeight.bold, fontSize: 18.0, )),

                                                        Text('El mantenimiento "${lista[index]['tipoMantenimiento']}"', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                                                      // Text(lista[index]['ultimoServicio'].toString()),
                                                        Text('Suele hacerse cada: ${lista[index]['frecuenciaMantenimiento'].toString()} km', textAlign: TextAlign.center,),
                                                        Text('Ya ha recorrido: ${kilometraje-lista[index]['ultimoServicio']} km\n', textAlign: TextAlign.center,),
                                                        //Text('Descripcion: ${lista[index]['descripcion']}km\n'),
                                                        Text('----------------------------\n', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                                                      ],
                                                    );
                                                  }),
                                                ),
                                              ),
                                              actions: <Widget>[
                                                  FlatButton(
                                                      onPressed:(){
                                                        lista.clear();
                                                        Navigator.of(context).pop();
                                                      },
                                                      child:Text('OK', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0))),
                                              ],
                                            );
                                          },
                                    );
                                }
                              });
                            });
                      },
                      heroTag: null,
                      
                  ),
                  SizedBox(
                        height: 100,
                        width: 10,
                  ),
                  FloatingActionButton(  
                        backgroundColor: HexColor('#174D80'),    
                        child: Icon(
                            Icons.add_alert,
                            size: 30,
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
                    var card = Card(
                        elevation: 10,  
                        margin: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        color: colorPorPrioridad(documentSnapshot['prioridad']),
                        child: ListTile(
                          dense: true,
                          leading: Builder(
                            builder:(BuildContext context){
                              return IconButton(
                                padding: const EdgeInsets.only(bottom: 3.0),
                                icon: Icon(seleccionarIcono2(documentSnapshot['estadoNotificacion'], "icono"),
                                            size: 50, color: seleccionarIcono2(documentSnapshot['estadoNotificacion'], "color"),
                                ),
                                onPressed: (){
                                  updateEstadoNotificacion(idVehiculo, documentSnapshot.id, documentSnapshot['estadoNotificacion']); 
                                },
                              );
                            },
                          ),      
                          title:Text(documentSnapshot['tipoMantenimiento'],
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          subtitle:Text(
                            'Se realiza cada: ${documentSnapshot['frecuenciaMantenimiento']} Km\nUltimo servicio: ${documentSnapshot['ultimoServicio']} Km\nDescripción: ${documentSnapshot['descripcion']}',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w200
                            ),
                          ),
                          
                          trailing: Wrap(
                            spacing: -1,
                            children: <Widget>[
                              IconButton(
                                padding: const EdgeInsets.only(top: 0),
                                icon: Icon(Icons.settings,
                                            size: 39,
                                            color: Colors.blue,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => 
                                    UpdateMantenimientosScreen(
                                        idMantenimiento: documentSnapshot.id.toString(),
                                        idVehiculo: documentSnapshot['idVehiculo'].toString(),
                                        tipoMantenimiento: documentSnapshot['tipoMantenimiento'].toString(),
                                        frecuenciaMantenimiento: documentSnapshot['frecuenciaMantenimiento'],
                                        ultimoServicio: documentSnapshot['ultimoServicio'],
                                        descripcion: documentSnapshot['descripcion'].toString() 
                                    ))
                                  );
                                },
                              ),

                              IconButton(
                                padding: const EdgeInsets.only(top: 0),
                                icon: Icon(
                                  Icons.delete,
                                  size: 35,
                                  color: Colors.red,
                                ),
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return  AlertDialog(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              contentPadding: EdgeInsets.all(5.0), //padding de la cajita
                                              title: Center(
                                                child: Text('¡Eliminar Notificación!'),
                                              ),
                                              elevation: 5.0,
                                              backgroundColor: Colors.red[100],
                                              content: Container(
                                                child: Center(
                                                  heightFactor: 1.6,
                                                  child: Text('¿Seguro que desea eliminarlo?'),
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed:(){
                                                      deleteMantenimiento(documentSnapshot.id);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child:Text('Si', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
                                                ),

                                                FlatButton(
                                                  padding: EdgeInsets.only(left: 1.0, right: 10.0),
                                                  onPressed:(){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child:Text('No', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0, color: Colors.red))
                                                ),
                                              ],
                                        ); 
                                      },
                                    );
                                }
                              ),
                            ],
                          ),
                        )
                      );
                    return InkWell(
                      onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return  AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    contentPadding: EdgeInsets.all(5.0), //padding de la cajita
                                    title: Text('Marcar Notificación como Completada'),
                                    elevation: 5.0,
                                    backgroundColor: Colors.blue[50],
                                    content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          new TextField(
                                              decoration: new InputDecoration(
                                                  icon: Icon(Icons.attach_money),
                                                  labelText: 'Precio Servicio', hintText: '10€'),
                                              onChanged: (String value) {
                                                  controllerPrecio = int.parse(value);  
                                              },
                                          ),

                                          new TextField(
                                              decoration: new InputDecoration(
                                                  icon: Icon(Icons.description),
                                                  labelText: 'Descripción', hintText: ''),
                                              onChanged: (String value) {
                                                  controllerDescripcion = value;  
                                              },
                                          ),
                                        ],
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        padding: EdgeInsets.only(left: 20.0),
                                        onPressed:(){
                                          Navigator.of(context).pop();
                                        },
                                        child:Text('cancel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0, color: Colors.red))
                                      ),

                                      FlatButton(
                                          onPressed:(){
                                            if(controllerPrecio != null){
                                                userBloc.addRegistro(
                                                    Registro(
                                                        tipoMantenimiento: documentSnapshot['tipoMantenimiento'],
                                                        kilometrajeMantenimiento: kilometraje,
                                                        fechaRealizado: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                                                        precioServicio: controllerPrecio,
                                                        descripcion: controllerDescripcion,
                                                    ), 
                                                    idVehiculo,
                                                                //idMantenimiento
                                                ).whenComplete((){
                                                      updateUltimoServicio(idVehiculo, documentSnapshot.id);
                                                  });
                                                  controllerPrecio = null; 
                                                  controllerDescripcion = "";   
                                                  Navigator.pop(context);     
                                            }
                                          },
                                          child:Text('add', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
                                      ),
                                    ],
                              ); 
                            },
                          );
                      },
                      key: Key(documentSnapshot['tipoMantenimiento']),
                      child: card
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