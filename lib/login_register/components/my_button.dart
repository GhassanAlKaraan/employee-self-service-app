import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  //text on button
  final String txt;

  //onTap function
  final Function()? onTap;

  //Updated the constructor
  const MyButton({super.key, required this.onTap, required this.txt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.red[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child:  Center(
          child: Text(
            txt,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
