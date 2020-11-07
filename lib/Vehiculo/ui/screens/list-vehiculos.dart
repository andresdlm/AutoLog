import 'package:autolog/Usuario/bloc/bloc_user.dart';
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
        
        
        ButtonAgregarVehiculo(),
        TitleHeader(title: "Mis Vehículos",),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').snapshots(),
          builder: (context, snapshots){
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshots.data.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot documentSnapshot = snapshots.data.docs[index];
            return Dismissible(
              onDismissed: (direction){
                //deleteTodos(documentSnapshot.id);
              },
              key: Key(documentSnapshot['Modelo']),
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                   title:Text(documentSnapshot['Color']),
                   subtitle:Text(documentSnapshot['Marca']),
                   trailing: IconButton(
                     icon: Icon(
                       Icons.delete,
                       color: Colors.red,
                     ),
                     onPressed: (){
                       //deleteTodos(documentSnapshot.id);
                     }),
              ),
              )
            );
          },
        );
      }),
        
        
      ],  
    );
  }

}

/*
Container(
  margin: EdgeInsets.only(
    top: 20.0,
    left:20.0,
    right: 20.0
  ),
  child: Row(
    children: [
      Text(
        "Mis Vehiculos",
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 26.0,
          fontWeight: FontWeight.w900
        ),
      textAlign: TextAlign.left,
      ),
    ],
  )
),
*/