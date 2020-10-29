import 'package:autolog/Usuario/model/user.dart';
import 'package:autolog/Usuario/repository/cloud_firestore_repository.dart';
import 'package:autolog/Vehiculo/model/vehiculo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:autolog/Usuario/repository/auth_repository.dart';

class UserBloc implements Bloc {

  // ignore: non_constant_identifier_names
  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;

  // Casos de uso de User
  //1. SignIn por Google
  Future<FirebaseUser> signIn() {
    return _auth_repository.signInFirebase();
  }

  //2. SignOut
  singOut() {
    _auth_repository.signOut();
  }

  //3. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);

  //4. Ingresar un nuevo vehiculo
  Future<void> updateVehiculoData(Vehiculo vehiculo) => _cloudFirestoreRepository.updateVehiculoData(vehiculo);

  @override
  void dispose() {
    
  }
}