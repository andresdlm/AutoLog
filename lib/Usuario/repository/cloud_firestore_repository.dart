import 'package:autolog/Usuario/model/usuario.dart';
import 'package:autolog/Usuario/repository/cloud_firestore_api.dart';
import 'package:autolog/Vehiculo/model/mantenimiento.dart';
import 'package:autolog/Vehiculo/model/registro.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/Vehiculo/ui/widgets/bannerVehiculo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreRepository {

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore() => _cloudFirestoreAPI.updateUserData();

  Future<void> createVehiculo(Vehiculo vehiculo) => _cloudFirestoreAPI.createVehiculo(vehiculo);

  void deleteVehiculo(String vehiculoID) => _cloudFirestoreAPI.deleteVehiculo(vehiculoID);

  Future<void> addMantenimiento(Mantenimiento mantenimiento, String idVehiculo) => _cloudFirestoreAPI.addMantenimiento(mantenimiento, idVehiculo);

  Future<void> addRegistro(Registro registro, String idVehiculo) => _cloudFirestoreAPI.addRegistro(registro, idVehiculo);

}