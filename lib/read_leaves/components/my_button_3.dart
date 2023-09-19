// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyButton3 extends StatelessWidget {

  //text on button
  final String txt;

  //onTap function
  final Function()? onTap;

  //button color
  final color;

  //Updated the constructor
  const MyButton3({super.key, required this.onTap, required this.txt, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          //border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
            color: Colors.grey,
            offset: Offset(4.0, 4.0),
          blurRadius: 5.0,
          spreadRadius: 1),
        BoxShadow(
            color: Colors.white,
            offset: Offset(-4.0, -4.0),
            blurRadius: 4.0,
            spreadRadius: 1),
        ]
        ),
        child:  Center(
          child: Text(
            txt,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
