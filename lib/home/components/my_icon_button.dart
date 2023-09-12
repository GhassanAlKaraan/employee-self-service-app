import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final Function()? onTap;

  const MyIconButton({super.key, required this.onTap});

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
                  offset: Offset(4.0, 4.0),
                  blurRadius: 5.0,
                  spreadRadius: 1),
              BoxShadow(
                  color: Colors.red,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 5.0,
                  spreadRadius: 1),
            ]),
        child: const Icon(Icons.android, size: 50),
      ),
    );
  }
}
