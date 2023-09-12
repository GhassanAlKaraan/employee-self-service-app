import 'package:flutter/material.dart';

class RegisterNow extends StatelessWidget {
  const RegisterNow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Not a member?',
          style: TextStyle(color: Colors.grey[700], fontSize: 14),
        ),
        const SizedBox(width: 4),
        Text(
          'Register now',
          style: TextStyle(
            color: Colors.red[900],
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}