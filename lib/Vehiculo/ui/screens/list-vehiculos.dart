import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/ui/screens/view-vehiculo.dart';
import 'package:autolog/Vehiculo/ui/widgets/buttonAgregarVehiculo.dart';
import 'package:autolog/widgets/title_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ListVehiculos extends StatelessWidget {

  UserBloc userBloc;
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    
    userBloc = BlocProvider.of<UserBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        
        Row(
          children: [
            Container(
              child: TitleHeader(title: "Mis Vehículos"),
              margin: EdgeInsets.only(left: 10),
            ),
            ButtonAgregarVehiculo(),
          ],
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').snapshots(),
          builder: (context, AsyncSnapshot snapshots){
            if(snapshots.data == null) return CircularProgressIndicator();
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshots.data.docs.length,
              itemBuilder: (context, index){
                DocumentSnapshot documentSnapshot = snapshots.data.docs[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewVehiculo()));
                  },
                  key: Key(documentSnapshot['modelo']),
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      title:Text(documentSnapshot['marca']),
                      subtitle:Text(documentSnapshot['modelo']),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: (){
                          userBloc.deleteVehiculo(documentSnapshot.id);
                        }
                      ),
                    ),
                  )
                );
              },
            );
          }
        ),
      ],  
    );
  }
}