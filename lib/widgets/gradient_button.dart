import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GradientButton extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onPressed;
  final Text text;
  final Icon icon;

  const GradientButton({Key key, this.width, this.height, this.onPressed, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(   //boton de login
      width: this.width,
      height: this.height,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [HexColor('#346FB8'), HexColor('0A356B') ]
        ),
      ),
      child: MaterialButton(
          onPressed: this.onPressed,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                text,
                icon,
              ],
            ),
          )),
    );
  }
}
