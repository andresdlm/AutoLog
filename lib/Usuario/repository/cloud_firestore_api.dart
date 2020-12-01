import 'package:autolog/Usuario/model/usuario.dart';
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
    String uid =  auth.currentUser.uid.toString();
    String name = auth.currentUser.displayName.toString();
    String mail = auth.currentUser.email.toString();
    String photoURL = auth.currentUser.photoURL.toString();
    String phoneNumber = auth.currentUser.phoneNumber.toString();

    try {
      await FirebaseFirestore.instance.collection("Users").doc(uid).get().then((doc) {
          if (doc.exists){
            users.doc(uid).update({
              'uid': uid,
              'name':name,
              'mail': mail,
            }).then((value) => print("User Added"))
                .catchError((error) => print("Failed to add user: $error"));
          } else{
            users.doc(uid).set({
              'uid': uid,
              'name':name,
              'mail': mail,
              'photoURL': photoURL,
              'phoneNumber' : phoneNumber,
              'pais': "",
            }).then((value) => print("User Added"))
                .catchError((error) => print("Failed to add user: $error"));
          }  
      });
    } catch (e) {
      return e.message; 
    }  
    
  }

  Future<void> updateUser(Usuario usuario) async{
    
    final User user = FirebaseAuth.instance.currentUser;
    user.updateProfile(displayName: usuario.name);

    CollectionReference documentReference= FirebaseFirestore.instance.collection('Users');
    await documentReference.doc(usuario.uid).update({
      'mail': usuario.email,
      'name': usuario.name,
      'phoneNumber': usuario.phoneNumber,
      'pais': usuario.pais,
    }).whenComplete(() => print('$usuario.uid, Actualizado'));
         
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
      'owner': user.uid,

    }).whenComplete((){
      print('$vehiculo.marca, $vehiculo.modelo created');
    });

    return null;
  }

  void updateVehiculo(Vehiculo vehiculo, String idVehiculo){
    final User user = FirebaseAuth.instance.currentUser;

    CollectionReference documentReference= FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car');

    documentReference.doc(idVehiculo).update({
      'marca': vehiculo.marca,
      'modelo': vehiculo.modelo,
      'year': vehiculo.year,
      'color': vehiculo.color,
    }).whenComplete(() => print('$idVehiculo, Actualizado'));
          
  }

   void updateMantenimiento(Mantenimiento mantenimiento, String idVehiculo, String idMantenimiento) async {

    final User user = FirebaseAuth.instance.currentUser;
    int kilometraje;
    String prioridad ="";
    
    Future<DocumentSnapshot> car = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).get();
    await car.then((DocumentSnapshot carSnapshot) => {
        kilometraje = carSnapshot['kilometraje'],
    });

    if(kilometraje-mantenimiento.ultimoServicio >= mantenimiento.frecuenciaMantenimiento){
          if(kilometraje-mantenimiento.ultimoServicio >= mantenimiento.frecuenciaMantenimiento && kilometraje-mantenimiento.ultimoServicio <= mantenimiento.frecuenciaMantenimiento +1000)
            prioridad = "BAJA";
          else if(kilometraje-mantenimiento.ultimoServicio > mantenimiento.frecuenciaMantenimiento + 1000 && kilometraje-mantenimiento.ultimoServicio <= mantenimiento.frecuenciaMantenimiento + 3000)
            prioridad = "MEDIA";
          else if(kilometraje-mantenimiento.ultimoServicio > mantenimiento.frecuenciaMantenimiento + 3000)
            prioridad = "ALTA";   
    };

    CollectionReference documentReference= FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection('Mantenimientos');
    await documentReference.doc(idMantenimiento).update({
      'tipoMantenimiento': mantenimiento.tipoMantenimiento,
      'frecuenciaMantenimiento': mantenimiento.frecuenciaMantenimiento,
      'ultimoServicio': mantenimiento.ultimoServicio,
      'descripcion': mantenimiento.descripcion,
      'prioridad': prioridad, 
    }).whenComplete(() => print('$idMantenimiento, Actualizado'));
          
  }

  void updateRegistro(Registro registro, String idVehiculo, String idRegistro) async {
      final User user = FirebaseAuth.instance.currentUser;

      CollectionReference documentReference= FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).collection('Registro');
      await documentReference.doc(idRegistro).update({
        'tipoMantenimiento': registro.tipoMantenimiento,
        'kilometrajeMantenimiento': registro.kilometrajeMantenimiento,
        'precioServicio': registro.precioServicio,
        'descripcion': registro.descripcion,
        'fechaRealizado': registro.fechaRealizado, 
      }).whenComplete(() => print('$idRegistro, Actualizado'));
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

  Future<void> addMantenimiento(Mantenimiento mantenimiento, String idVehiculo) async{
    final User user = FirebaseAuth.instance.currentUser;
    int kilometraje;
    String prioridad ="";
    
    Future<DocumentSnapshot> car = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').doc(idVehiculo).get();
    await car.then((DocumentSnapshot carSnapshot) => {
        kilometraje = carSnapshot['kilometraje'],
    });

    if(kilometraje-mantenimiento.ultimoServicio >= mantenimiento.frecuenciaMantenimiento){
          if(kilometraje-mantenimiento.ultimoServicio >= mantenimiento.frecuenciaMantenimiento && kilometraje-mantenimiento.ultimoServicio <= mantenimiento.frecuenciaMantenimiento +1000)
            prioridad = "BAJA";
          else if(kilometraje-mantenimiento.ultimoServicio > mantenimiento.frecuenciaMantenimiento + 1000 && kilometraje-mantenimiento.ultimoServicio <= mantenimiento.frecuenciaMantenimiento + 3000)
            prioridad = "MEDIA";
          else if(kilometraje-mantenimiento.ultimoServicio > mantenimiento.frecuenciaMantenimiento + 3000)
            prioridad = "ALTA";   
    };

    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car');
    await documentReference.doc(idVehiculo).collection('Mantenimientos').doc().set({
      'tipoMantenimiento': mantenimiento.tipoMantenimiento,
      'frecuenciaMantenimiento': mantenimiento.frecuenciaMantenimiento,
      'ultimoServicio': mantenimiento.ultimoServicio,
      'descripcion': mantenimiento.descripcion,
      'idVehiculo': idVehiculo,
      'prioridad': prioridad,
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