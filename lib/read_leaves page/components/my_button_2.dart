import 'package:flutter/material.dart';

class MyButton2 extends StatelessWidget {

  //text on button
  final String txt;

  //onTap function
  final Function()? onTap;

  //Updated the constructor
  const MyButton2({super.key, required this.onTap, required this.txt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child:  Center(
          child: Text(
            txt,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
