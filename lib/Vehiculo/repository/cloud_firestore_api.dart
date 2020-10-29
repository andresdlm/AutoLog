/*import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String VEHICULOS = "vehiculos";

  final Firestore _db = Firestore.instance;

  void updateVehiculoData(Vehiculo vehiculo) async {
    DocumentReference ref = _db.collection(VEHICULOS).document(vehiculo.id);
    return ref.setData({
      'id': vehiculo.id,
      'marca': vehiculo.marca,
      'modelo': vehiculo.modelo,
      'year': vehiculo.year,
      'color': vehiculo.color,
      'kilometraje': vehiculo.kilometraje,
      'userOwner': vehiculo.userOwner
    }, merge: true);
  }
}*/