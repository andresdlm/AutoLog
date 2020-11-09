import 'package:flutter/material.dart';

class ListMantenimientos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF2196F3),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}