import 'package:autolog/Usuario/model/usuario.dart';
import 'package:autolog/Usuario/repository/cloud_firestore_api.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/Vehiculo/ui/widgets/bannerVehiculo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreRepository {

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore() => _cloudFirestoreAPI.updateUserData();

  Future<void> createVehiculo(Vehiculo vehiculo) => _cloudFirestoreAPI.createVehiculo(vehiculo);

  //List<BannerVehiculo> buildVehiculos(List<DocumentSnapshot> vehiculosListSnapshot) =>_cloudFirestoreAPI.buildVehiculos(vehiculosListSnapshot);

}