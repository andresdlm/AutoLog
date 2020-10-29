import 'package:autolog/Usuario/model/user.dart';
import 'package:autolog/Usuario/repository/cloud_firestore_api.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';

class CloudFirestoreRepository {

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) => _cloudFirestoreAPI.updateUserData(user);

  Future<void> updateVehiculoData(Vehiculo vehiculo) => _cloudFirestoreAPI.updateVehiculoData(vehiculo);

}