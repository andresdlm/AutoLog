import 'package:autolog/Usuario/bloc/bloc_user.dart';
import 'package:autolog/Vehiculo/ui/screens/view-vehiculo.dart';
import 'package:autolog/Vehiculo/ui/screens/vehiculo_details.dart';
import 'package:autolog/Vehiculo/ui/screens/update_vehiculo.dart';
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
    return new Scaffold (
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
            "AutoLog",
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: new Container(
          color: Colors.red[50],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: TitleHeader(title: "Mis Vehículos", fontSize: 30,),
                margin: EdgeInsets.only(left: 10, top: 30, bottom: 15),
              ),
              
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').snapshots(),
                builder: (context, snapshots){
                  if(snapshots.data == null) 
                  return Container( 
                      padding: EdgeInsets.only(top: 150.0),
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
                                        MaterialPageRoute(builder: (context) => ViewVehiculo(idVehiculo: documentSnapshot.id.toString(), marca: documentSnapshot['marca'], modelo: documentSnapshot['modelo']))
                                      );
                                    },
                                    key: Key(documentSnapshot['modelo']),
                                    child: Card(
                                      elevation: 10,
                                      margin: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                        color: Colors.pink[100], //color de la tarjeta
                                      child: ListTile(
                                        dense: true,
                                        leading: Icon(Icons.directions_car, size: 40, color: Colors.grey[800]),
                                        title:Text('${documentSnapshot['marca']} ${documentSnapshot['modelo']}',style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),),
                                        subtitle:Text('Kilometraje: ${documentSnapshot['kilometraje']}\n${documentSnapshot['color']} ${documentSnapshot['year']}',style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1),),
                                        trailing: Wrap(
                                          spacing: -5,
                                          children: <Widget>[
                                            IconButton(
                                                padding: const EdgeInsets.only(top: 0),
                                                icon: Icon(
                                                Icons.settings,
                                                size: 38,
                                                color: Colors.blue[700],
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => 
                                                        UpdateVehiculoScreen(idVehiculo: documentSnapshot.id.toString(),
                                                                            marca: documentSnapshot['marca'].toString(),
                                                                            modelo: documentSnapshot['modelo'].toString(),
                                                                            year: documentSnapshot['year'].toString(),
                                                                            color: documentSnapshot['color'].toString() 
                                                        ))
                                                      //MaterialPageRoute(builder: (context) => vehiculoDetails(idVehiculo: documentSnapshot.id.toString()))
                                                  );
                                                },
                                            ),
                                            IconButton(
                                                padding: const EdgeInsets.only(top: 0),
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 38,
                                                  color: Colors.red,
                                                  ),
                                                onPressed: (){
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context){
                                                      return  AlertDialog(
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                            contentPadding: EdgeInsets.all(5.0), //padding de la cajita
                                                            title: Center(
                                                              child: Text('¡Eliminar Vehiculo!'),
                                                            ),
                                                            elevation: 5.0,
                                                            backgroundColor: Colors.red[100],
                                                            content: Container(
                                                              child: Center(
                                                                heightFactor: 1.6,
                                                                child: Text('¿Seguro que desea eliminarlo?'),
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                  onPressed:(){
                                                                    userBloc.deleteVehiculo(documentSnapshot.id);
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child:Text('Si', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
                                                              ),

                                                              FlatButton(
                                                                padding: EdgeInsets.only(left: 1.0, right: 10.0),
                                                                onPressed:(){
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child:Text('No', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0, color: Colors.red))
                                                              ),
                                                            ],
                                                      ); 
                                                    },
                                                  );
                                                },
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
          ),
        ),
    );
  }
}

