import 'package:flutter/material.dart';
import 'package:new_ess/components/square_tile.dart';

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
                thickness: 0.5,
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

            const SquareTile(imagePath: 'assets/images/logos/google.png'),
            const SizedBox(width: 10,),
            Expanded(
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
      //const SizedBox(height: 20),
      // google sign in button
      //const SquareTile(imagePath: 'assets/images/logos/google.png'),
    ]);
  }
}
