import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/ui/screens/view-vehiculo.dart';
import 'package:autolog/Vehiculo/ui/screens/vehiculo_details.dart';
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
        Container(
          child: TitleHeader(title: "Mis Vehículos"),
          margin: EdgeInsets.only(left: 10, top: 15, bottom: 15),
        ),
        
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').snapshots(),
          builder: (context, snapshots){
            if(snapshots.data == null) 
            return Container( 
                padding: EdgeInsets.only(top: 250.0),
                child: Center(
                      child: CircularProgressIndicator()
                    ),
            );
                
            switch(snapshots.connectionState){
              case ConnectionState.active:            
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshots.data.docs.length,
                      itemBuilder: (context, index){
                            DocumentSnapshot documentSnapshot = snapshots.data.docs[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ViewVehiculo(idVehiculo: documentSnapshot.id.toString()))
                                );
                              },
                              key: Key(documentSnapshot['modelo']),
                              child: Card(
                                elevation: 10,
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                                  color: Colors.blue[100],
                                child: ListTile(
                                  dense: true,
                                  leading: Icon(Icons.directions_car, size: 40),
                                  title:Text('${documentSnapshot['marca']} ${documentSnapshot['modelo']}',style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),),
                                  subtitle:Text(documentSnapshot['color'],style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1),),
                                  trailing: Wrap(
                                    spacing: -5,
                                    children: <Widget>[
                                      IconButton(
                                          padding: const EdgeInsets.only(top: 0),
                                          icon: Icon(
                                          Icons.settings,
                                          size: 35,
                                          color: Colors.blue,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => vehiculoDetails(idVehiculo: documentSnapshot.id.toString()))
                                            );
                                          },
                                      ),
                                      IconButton(
                                          padding: const EdgeInsets.only(top: 0),
                                          icon: Icon(
                                          Icons.delete,
                                          size: 35,
                                          color: Colors.red,
                                          ),
                                          onPressed: (){
                                          userBloc.deleteVehiculo(documentSnapshot.id);
                                          }
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            );
                      },
                  );
              default: return Text("Loading data");
            }
          }),
          Align(alignment: Alignment.bottomCenter, child: ButtonAgregarVehiculo(),),  
      ],  
    );
  }
}

