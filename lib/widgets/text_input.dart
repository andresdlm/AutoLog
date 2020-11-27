import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {

  final String hintText;
  final String labelText;
  final TextInputType inputType;
  final TextEditingController controller;
  int maxLines = 1;

  TextInput({
    Key key,
    @required this.hintText,
    this.labelText,
    @required this.inputType,
    @required this.controller,
    this.maxLines
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20.0, left: 20.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        maxLines: maxLines,
        style: TextStyle(
          height: 1.6,
          fontSize: 15.0,
          fontFamily: "Lato",
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold
        ),

        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFe5e5e5),
          border: InputBorder.none,
          labelText: labelText, hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFe5e5e5)),
            borderRadius: BorderRadius.all(Radius.circular(9.0))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFe5e5e5)),
              borderRadius: BorderRadius.all(Radius.circular(9.0))
          )

        ),
      ),
    );
  }
}