import 'package:autolog/Vehiculo/model/registro.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/Vehiculo/model/mantenimiento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String VEHICULOS = "vehiculos";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection('Users');
  


  Future<void> updateUserData() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    String name = auth.currentUser.displayName.toString();
    String mail = auth.currentUser.email.toString();
    String phoneNumber = auth.currentUser.phoneNumber.toString();
    String photoURL = auth.currentUser.photoURL.toString();

    return users.doc(uid).set({
      'uid': uid,
      'name':name,
      'mail': mail,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,

    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> createVehiculo(Vehiculo vehiculo){
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users');

    documentReference.doc(user.uid).collection('Car').doc().set({
      'marca': vehiculo.marca,
      'modelo': vehiculo.modelo,
      'year': vehiculo.year,
      'color': vehiculo.color,
      'kilometraje': vehiculo.kilometraje,
      'kilometrajeAnterior': vehiculo.kilometraje,
      'owner': user.uid,

    }).whenComplete((){
      print('$vehiculo.marca, $vehiculo.modelo created');
    });

    return null;
  }

  deleteVehiculo(String idVehiculo){
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users');

    documentReference.doc(user.uid).collection('Car').doc(idVehiculo).delete().whenComplete((){
      print('$idVehiculo deleted');
    });

    var queryMantenimientos = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection('Mantenimientos')
    .where('idVehiculo', isEqualTo: idVehiculo);
    queryMantenimientos.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });

    var queryRegistros = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection('Registro')
    .where('idVehiculo', isEqualTo: idVehiculo);
    queryRegistros.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });

  }

  Future<void> addMantenimiento(Mantenimiento mantenimiento, String idVehiculo){
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car');
    print(mantenimiento);
    print(idVehiculo);

    documentReference.doc(idVehiculo).collection('Mantenimientos').doc().set({
      'tipoMantenimiento': mantenimiento.tipoMantenimiento,
      'frecuenciaMantenimiento': mantenimiento.frecuenciaMantenimiento,
      'ultimoServicio': mantenimiento.ultimoServicio,
      'descripcion': mantenimiento.descripcion,
      'idVehiculo': idVehiculo,
      'prioridad': '',
      'estadoNotificacion': true,

    }).whenComplete((){
      print('$mantenimiento.tipoMantenimiento created');
    });

    return null;
  }

  Future<void> addRegistro(Registro registro, String idVehiculo) async{
    int kilometraje;
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection('Registro');
    print(registro);
    print(idVehiculo);

    if(registro.kilometrajeMantenimiento == null){
      Future<DocumentSnapshot> car = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).get();
      await car.then((DocumentSnapshot carSnapshot) => {
        kilometraje = carSnapshot['kilometraje'],
      });
      documentReference.doc().set({
        'tipoMantenimiento': registro.tipoMantenimiento,
        'kilometrajeMantenimiento': kilometraje,
        'fechaRealizado': registro.fechaRealizado,
        'precioServicio': registro.precioServicio,
        'descripcion': registro.descripcion,
        'idVehiculo': idVehiculo,
      });
    }else{
      documentReference.doc().set({
        'tipoMantenimiento': registro.tipoMantenimiento,
        'kilometrajeMantenimiento': registro.kilometrajeMantenimiento,
        'fechaRealizado': registro.fechaRealizado,
        'precioServicio': registro.precioServicio,
        'descripcion': registro.descripcion,
        'idVehiculo': idVehiculo,

      }).whenComplete((){
        print('$registro.tipoMantenimiento created');
      });
    }
    

    return null;
  }
  

}