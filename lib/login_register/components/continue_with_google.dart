import 'package:flutter/material.dart';
import '../services/google_auth_service.dart';
import 'square_tile.dart';

class ContinueGoogle extends StatelessWidget {
  const ContinueGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                thickness: 1.0,
                color: Colors.grey[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Or continue with',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
            ),

            SquareTile(
                onTap: () => GoogleAuthService().signInWithGoogle(),
                imagePath: 'assets/images/logos/google.png'),
            const SizedBox(width: 10,),
            Expanded(
              child: Divider(
                thickness: 1.0,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
