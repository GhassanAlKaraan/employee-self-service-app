import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {

  final Function()? onTap;
  MyIconButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 90,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(5.0, 5.0),
                  blurRadius: 1,
                  spreadRadius: 1),
              BoxShadow(
                  color: Colors.red,
                  offset: Offset(-5.0, -5.0),
                  blurRadius:1,
                  spreadRadius: 1),
            ]),
        child: const Icon(Icons.android, size: 50),
      ),
    );
  }
}
