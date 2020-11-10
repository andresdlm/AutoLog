import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {

  final String title;
  double fontSize = 30;

  TitleHeader({Key key, @required this.title, double this.fontSize});

  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontFamily: "Lato",
        fontWeight: FontWeight.bold
      ),
    );
  }
}