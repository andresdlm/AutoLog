import 'package:flutter/material.dart';


class ButtonBlue extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;
  final List<Color> colores;

  ButtonBlue({
    Key key,
    @required this.buttonText,
    @required this.onPressed,
    this.colores,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(
            top: 30.0,
            left: 50.0,
            right: 50.0,
        ),
        height: 55.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
              colors: colores,
              begin: FractionalOffset(0.2, 0.0),
              end: FractionalOffset(1.0, 1.9),
              stops: [0.0, 0.6],
              tileMode: TileMode.clamp

            )

        ),

        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: "Lato",
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),

          ),
        ),

      ),
    );
  }

}