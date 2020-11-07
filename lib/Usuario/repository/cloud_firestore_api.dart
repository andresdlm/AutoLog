import 'package:autolog/Usuario/model/user.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:autolog/Vehiculo/ui/widgets/bannerVehiculo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String VEHICULOS = "vehiculos";

  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  void updateUserData(User user) async {
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return ref.setData({
      'id': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      //'misVehiculos': user.misVehiculos,
      'lastSignIn': DateTime.now()
    }, merge: true);
  }

  Future<void> updateVehiculoData(Vehiculo vehiculo) async {
    CollectionReference refVehiculos = _db.collection(VEHICULOS);
    String uid = (await _auth.currentUser()).uid;
    
    
    await _auth.currentUser().then((FirebaseUser user) {

      refVehiculos.add({
        'marca': vehiculo.marca,
        'modelo': vehiculo.modelo,
        'year': vehiculo.year,
        'color': vehiculo.color,
        'kilometraje': vehiculo.kilometraje,
        'userOwner': _db.document("$USERS/$uid"),
      }).then((DocumentReference dr){
        dr.get().then((DocumentSnapshot snapshot) {
          snapshot.documentID;
          DocumentReference refUsers = _db.collection(USERS).document(user.uid);
          refUsers.updateData({
            'misVehiculos' : FieldValue.arrayUnion([_db.document("$VEHICULOS/${snapshot.documentID}")])
          });
        });
      });
    });
  }

  List<BannerVehiculo> buildVehiculos(List<DocumentSnapshot> vehiculosListSnapshot) {
    List<BannerVehiculo> bannerVehiculos = List<BannerVehiculo>();
    print("\n\n\n\n");
    print(_auth.currentUser().toString());
    
    print("+++++++++++++++++++++++++++++++++");
    print(vehiculosListSnapshot.first);
    print("+++++++++++++++++++++++++++++++++");
    
    vehiculosListSnapshot.forEach((v) { 
      if(v.data['userOwner'] == _auth.currentUser().toString()) {
        bannerVehiculos.add(BannerVehiculo(
        Vehiculo(
          marca: v.data['marca'],
          modelo: v.data['modelo'],
          year: v.data['year'],
          color: v.data['color'],
          kilometraje: v.data['kilometraje'],
        )
        ));
      }
    });

    return bannerVehiculos;
  }

}